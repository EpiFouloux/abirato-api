require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:headers) { valid_headers.except('Authorization') }
  let(:users) { create_list(:user, 5)}

  describe 'GET /users' do
    before(:each) do
      users
      get "/users"
    end

    it 'returns users' do
      expect(json).not_to be_empty
      count = users.count
      expect(json.size).to eq count
      count.times do |index|
        expect(json[index][:name]).to eq(users[index].name)
        expect(json[index][:email]).to be_nil
        expect(json[index][:level]).to eq(users[index].level)
        expect(json[index][:experience_amount]).to eq(users[index].experience_amount)
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    let(:user) { users.sample }

    before(:each) do
      get "/users/#{user.id}"
    end

    it 'returns user' do
      expect(json).not_to be_empty
      expect(json[:name]).to eq(user.name)
      expect(json[:email]).to be_nil
      expect(json[:level]).to eq(user.level)
      expect(json[:experience_amount]).to eq(user.experience_amount)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # User signup test suite
  describe 'POST /signup' do

    let(:user) { build(:user) }
    let(:valid_attributes) { attributes_for(:user, password_confirmation: user.password) }

    context 'when valid request' do
      before(:each) do
        post '/signup', params: valid_attributes.to_json, headers: headers
      end

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json[:message]).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json[:auth_token]).not_to be_nil
      end
    end

    context 'when invalid request' do
      before(:each) do
        post '/signup', params: {}, headers: headers
      end

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json[:message])
            .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:user) { users.sample }

    context 'with valid params' do
      let (:valid_params) do
        {
            name: 'tototo',
            email: 'toto@toto.com'
        }
      end

      before(:each) do
        put "/users/#{user.id}", params: valid_params.to_json, headers: headers
      end

      it 'returns the object updated' do
        expect(json[:name]).to eq(valid_params[:name])
        expect(json[:email]).to be_nil
        expect(json[:level]).to eq(user.level)
        expect(json[:experience_amount]).to eq(user.experience_amount)
      end

      it 'updates the record' do
        user.reload
        expect(user.name). to eq(valid_params[:name])
        expect(user.email). to eq(valid_params[:email])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid params' do
      let (:invalid_params) do
        {
            level: '100'
        }
      end

      before(:each) do
        put "/users/#{user.id}", params: invalid_params.to_json, headers: headers
      end

      it 'returns an error' do
        expect(json[:message])
            .to match(/param is missing or the value is empty: No allowed parameters provided/)
      end

      it 'does not update the record' do
        user.reload
        expect(user.level).not_to eq(invalid_params[:level])
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end


  describe 'DELETE /users/:id' do
    let!(:user) { create(:user)}

    before(:each) do
      expect(User.count).to eq(1)
      delete "/users/#{user.id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
      expect(User.count).to eq(0)
    end
  end
end