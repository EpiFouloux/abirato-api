require 'rails_helper'

RSpec.describe 'Character Classs API', type: :request do
  let (:character_classes) { Character::Class.all }

  describe 'GET /classes' do

    before(:each) do
      get "/classes"
    end

    it 'returns character_classes' do
      expect(json).not_to be_empty
      count = character_classes.count
      expect(json.size).to eq count
      count.times do |index|
        expect(json[index][:name]).to eq(character_classes[index].name)
        expect(json[index][:traits]).to eq(character_classes[index].traits)
        expect(json[index][:class_type]).to eq(character_classes[index].class_type)
        expect(json[index][:skill]).to eq(character_classes[index].skill_id)
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /classes/:id' do
    let(:character_class) { character_classes.sample }
    let(:character_class_id) { character_class.id }

    before(:each) do
      get "/classes/#{character_class_id}"
    end

    context 'when the record exists' do
      it 'returns the character_class' do
        expect(json).not_to be_empty
        expect(json[:name]).to eq(character_class.name)
        expect(json[:traits].count).to eq(3)
        expect(json[:traits]).to eq(character_class.traits)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:character_class_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Character::Class with 'id'=100")
      end
    end
  end
end