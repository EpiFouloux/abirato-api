require 'rails_helper'

RSpec.describe 'Character Instance API', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:user2_id) { create(:user).id }
  let(:headers) { valid_headers }

  context 'With existing character instances' do
    let(:template) { Character::Template.all.sample }
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
        get "/users/#{user_id}/characters", params: {}, headers: headers
      end

      it 'returns instances' do
        expect(json).not_to be_empty
        expect(json.size).to eq(instances.count)
        json.each do |elem|
          expect(elem[:template]).to eq(template.id)
          expect(elem[:classes].count).to eq(1)
          expect(elem[:classes][0]).to have_key(:id)
          expect(elem[:classes][0]).to have_key(:name)
          expect(elem[:classes][0]).to have_key(:category)
        end
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'GET /characters/:id' do
      before(:each) do
        get "/characters/#{instance_id}", params: {}, headers: headers
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
          expect(json[:waiting_trait]).to eq(instance.waiting_trait?)
          expect(json[:waiting_modifier]).to eq(instance.waiting_modifier?)
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

  describe 'POST /characters' do
    let(:template) { Character::Template.all.sample }
    let(:valid_attributes) {
      {
        template_id: template.id,
        additive_trait: 'power',
        name: 'Foobar'
      }
    }

    context 'when the request is valid' do
      before(:each) do
        expect(Character::Instance.count).to eq(0)
        post "/characters", params: valid_attributes.to_json, headers: headers
      end

      it 'creates a character' do
        expect(Character::Instance.count).to eq(1)
        expect(json[:name]).to eq('Foobar')
        expect(json[:experience_amount]).to eq(100)
        expect(json[:level]).to eq(1)
        expect(json[:target_experience_amount]).to eq(400)
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
        post "/characters", params: invalid_params.to_json, headers: headers
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
        post "/characters", params: invalid_params.to_json, headers: headers
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

  describe 'PUT /characters/:id' do
    let(:instance) { create(:character_instance, additive_power: 0, additive_control: 0, additive_swiftness: 1) }
    let(:instance_id) { instance.id }

    context 'with an additive trait' do
      let(:valid_attributes) {
        {
            additive_trait: 'control'
        }
      }

      context 'when the record exists and the user and level is correct' do
        before(:each) do
          instance.user = user
          instance.experience_amount = Character::Instance.target_experience(10)
          instance.save!
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns the object updated' do
          expect(json[:traits][:control]).to eq(instance.control + 1)
        end

        it 'updates the record' do
          expect(instance.additive_control).to eq(0)
          instance.reload
          expect(instance.additive_control). to eq(1)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record exists and the user is incorrect' do
        before(:each) do
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns an error message' do
          expect(json[:message]).to eq("You can't edit an other user's characters")
        end

        it "doesn't update the record" do
          expect(instance.additive_control).to eq(0)
          instance.reload
          expect(instance.additive_control). to eq(0)
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when the record exists and the level is incorrect' do
        before(:each) do
          instance.user = user
          instance.experience_amount = Character::Instance.target_experience(5)
          instance.save!
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns an error message' do
          expect(json[:message]).to eq("Character is not waiting for any trait")
        end

        it "doesn't update the record" do
          expect(instance.additive_control).to eq(0)
          instance.reload
          expect(instance.additive_control). to eq(0)
          expect(instance.name).not_to eq(valid_attributes[:name])
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    context 'with an additive modifier' do
      let(:valid_attributes) {
        {
            additive_modifier: 'strength'
        }
      }

      context 'when the record exists and the user and level is correct' do
        before(:each) do
          instance.user = user
          instance.experience_amount = Character::Instance.target_experience(10)
          instance.save!
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns the object updated' do
          expect(json[:modifiers][:strength]).to eq(instance.strength + 1)
        end

        it 'updates the record' do
          expect(instance.additive_strength).to eq(0)
          instance.reload
          expect(instance.additive_strength). to eq(1)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record exists and the user is incorrect' do
        before(:each) do
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns an error message' do
          expect(json[:message]).to eq("You can't edit an other user's characters")
        end

        it "doesn't update the record" do
          expect(instance.additive_strength).to eq(0)
          instance.reload
          expect(instance.additive_strength). to eq(0)
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end

      context 'when the record exists and the level is incorrect' do
        before(:each) do
          instance.user = user
          instance.experience_amount = Character::Instance.target_experience(2)
          instance.save!
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns an error message' do
          expect(json[:message]).to eq("Character is not waiting for any modifier")
        end

        it "doesn't update the record" do
          expect(instance.additive_strength).to eq(0)
          instance.reload
          expect(instance.additive_strength). to eq(0)
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    context 'with a new name' do
      let(:valid_attributes) {
        {
            name: 'foooo2'
        }
      }

      context 'when the record exists and the user is correct' do
        before(:each) do
          instance.user = user
          instance.save!
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns the object updated' do
          expect(json[:name]).to eq(valid_attributes[:name])
        end

        it 'updates the record' do
          instance.reload
          expect(instance.name). to eq(valid_attributes[:name])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record exists and the user is incorrect' do
        before(:each) do
          put "/characters/#{instance_id}", params: valid_attributes.to_json, headers: headers
        end

        it 'returns an error message' do
          expect(json[:message]).to eq("You can't edit an other user's characters")
        end

        it "doesn't update the record" do
          instance.reload
          expect(instance.name).not_to eq(valid_attributes[:name])
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe 'DELETE /characters/:id' do
    let(:instance) { create(:character_instance) }
    let!(:instance_id) { instance.id }

    context 'when the record exists and the user is correct' do
      before(:each) do
        instance.user = user
        instance.save!
        expect(Character::Instance.count).to eq(1)
        delete "/characters/#{instance_id}", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(json[:id]).not_to be_nil
        expect(Character::Instance.count).to eq(0)
      end
    end

    context 'when the record exists and the user is incorrect' do
      before(:each) do
        expect(Character::Instance.count).to eq(1)
        delete "/characters/#{instance_id}", params: {}, headers: headers
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
        expect(Character::Instance.count).to eq(1)
      end
    end
  end
end
