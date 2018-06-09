require 'rails_helper'

RSpec.describe 'Character Instance API', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  context 'With existing character instances' do
    let(:template) { create(:character_template) }
    let!(:instances) {
      create_list(
        :character_instance,
        10,
        template: template,
        user: user
      )
    }
    let(:instance_id) { instances.first.id }
    describe 'GET /users/:id/characters' do
      before(:each) do
        get "/users/#{user_id}/characters"
      end

      it 'returns instances' do
        expect(json).not_to be_empty
        expect(json.size).to eq(instances.count)
        json.each do |elem|
          expect(elem[:template]).to eq(template.id)
          expect(elem[:classes].count).to eq(1)
        end
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET /users/:id/characters/:id' do
      before(:each) do
        get "/users/#{user_id}/characters/#{instance_id}"
      end

      context 'when the record exists' do
        it 'returns the instance' do
          instance = instances.first
          expect(json).not_to be_empty
          expect(json[:name]).to eq(instance.name)
          expect(json[:level]).to eq(instance.level)
          expect(json[:experience_amount]).to eq(instance.experience_amount)
          expect(json[:template]).to eq(instance.template.id)
          expect(json[:nature]).to eq(instance.nature.id)
          expect(json[:traits].count).to eq(3)
          expect(json[:traits][:power]).to eq(instance.power)
          expect(json[:traits][:control]).to eq(instance.control)
          expect(json[:traits][:swiftness]).to eq(instance.swiftness)
          expect(json[:modifiers].count).to eq(4)
          expect(json[:modifiers][:strength]).to eq(instance.strength)
          expect(json[:modifiers][:constitution]).to eq(instance.constitution)
          expect(json[:modifiers][:dexterity]).to eq(instance.dexterity)
          expect(json[:modifiers][:intelligence]).to eq(instance.intelligence)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:instance_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to include("Couldn't find Character::Instance with 'id'=100")
        end
      end
    end
  end

  describe 'POST /users/:id/characters' do
    let(:template) { create(:character_template) }
    let(:sclass) {
      create(
        :special_class,
        power: template.nature.power + 1,
        control: template.nature.control,
        swiftness: template.nature.swiftness
      )
    }
    let(:valid_attributes) {
      {
        template_id: template.id,
        additive_trait: 'power',
        name: 'Foobar',
      }
    }

    context 'when the request is valid' do
      before(:each) do
        expect(Character::Instance.count).to eq(0)
        sclass
        post "/users/#{user_id}/characters", params: valid_attributes
      end

      it 'creates a character' do
        expect(Character::Instance.count).to eq(1)
        expect(json[:name]).to eq('Foobar')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params){
        {
            name: 'foobar'
        }
      }

      before(:each) do
        post "/users/#{user_id}/characters", params: invalid_params
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/param is missing or the value is empty: template_id/)
      end
    end

    context 'when the request is forbidden' do
      let(:invalid_params){
        {

            template_id: template.id,
            additive_trait: 'paware',
            name: 'Foobar',
        }
      }

      before(:each) do
        post "/users/#{user_id}/characters", params: invalid_params
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Additive trait is invalid/)
      end
    end
  end

  describe 'PUT /users/:id/characters/:id' do
    let(:valid_attributes) {
      {
        additive_trait: 'control',
        name: 'foooo2'
      }
    }
    let(:instance) { create(:character_instance, additive_power: 0, additive_control: 0, additive_swiftness: 1) }
    let(:sclass) {
      create(
          :prestigious_class,
          power: instance.power,
          control: instance.control + 1,
          swiftness: instance.swiftness
      )
    }
    let(:instance_id) { instance.id }

    context 'when the record exists' do
      before(:each) do
        sclass
        put "/users/#{user_id}/characters/#{instance_id}", params: valid_attributes
      end

      it 'returns the object updated' do
        expect(json[:name]).to eq(valid_attributes[:name])
        expect(json[:traits][:control]).to eq(instance.control + 1)
      end

      it 'updates the record' do
        expect(instance.additive_control).to eq(0)
        instance.reload
        expect(instance.additive_control). to eq(1)
        expect(instance.name). to eq(valid_attributes[:name])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /users/:id/characters/:id' do
    let!(:instance_id) { create(:character_instance).id }

    before(:each) do
      expect(Character::Instance.count).to eq(1)
      delete "/users/#{user_id}/characters/#{instance_id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
      expect(Character::Instance.count).to eq(0)
    end
  end
end
