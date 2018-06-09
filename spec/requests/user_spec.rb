require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let!(:users) { create_list(:user, 5) }
  let(:user_id) { users.last.id }

  describe 'GET /users' do

    before(:each) do
      get "/users"
    end

    it 'return users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(users.count)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    before (:each) do
      get "/users/#{user_id}"
    end

    context 'When the user exists' do
      it 'returns the instance' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'When the user does not exist' do
      let(:user_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) {
      {
        mail: 'foo@bar.fr',
          name: 'foo',
          password_digest: 'toto'
      }
    }

    context 'When the request is valid' do
      before(:each) do
        post "/users", params: valid_attributes
      end


      it 'creates a character' do
        expect(json['name']).to eq(valid_attributes[:name])
        expect(json['mail']).to eq(valid_attributes[:mail])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'When the request is invalid' do
      before(:each) do
        post "/users", params: { name: 'foo'}
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Mail can't be blank/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) {
      {
        name: 'foo2',
        mail: 'f@f.com'
      }
    }

    context 'when the user exists' do
      before(:each) do
        put "/users/#{user_id}", params: valid_attributes
      end

      it 'updates the record' do
        expect(response.body).to be_empty
        users.last.reload
        expect(users.last.name).to eq(valid_attributes[:name])
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before(:each) do
      delete "/users/#{user_id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end