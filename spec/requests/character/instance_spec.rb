RSpec.describe 'Character Instance API', type: :request do
  let(:template) { create(:character_template) }
  let(:sclass) { create(:special_class)}
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let!(:instances) { 
    create_list(
      :character_instance,
      10,
      template: template,
      special_class: sclass,
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
        expect(json).not_to be_empty
        expect(json['id']).to eq(instance_id)
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
        expect(response.body).to match(/Couldn't find CharacterInstance/)
      end
    end
  end

  describe 'POST /users/:id/characters' do
    let(:template) { create(:character_template) }
    let(:valid_attributes) {
      {
          template_id: template.id,
          additive_power: 1,
          name: 'Foobar',
          created_by: '1'
      }
    }

    context 'when the request is valid' do
      before(:each) do
        post "/users/#{user_id}/characters", params: valid_attributes
      end

      it 'creates a character' do
        expect(json['name']).to eq('Foobar')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before(:each) do
        post "/users/#{user_id}/characters", params: {name: 'Foobar'}
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /users/:id/characters/:id' do
    let(:valid_attributes) {
      {
          additive_control: 1
      }
    }

    context 'when the record exists' do
      before(:each) do
        put "/users/#{user_id}/characters/#{instance_id}", params: valid_attributes
      end

      it 'updates the record' do
        expect(response.body).to be_empty # TODO: wtf is this shitty test
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /users/:id/characters:id' do
    before(:each) do
      delete "/users/#{user_id}/characters#{instance_id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end