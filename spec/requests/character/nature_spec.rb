require 'rails_helper'

RSpec.describe 'Character Natures API', type: :request do
  let (:natures) { Character::Nature.all }

  describe 'GET /natures' do

    before(:each) do
      get "/natures"
    end

    it 'returns natures' do
      expect(json).not_to be_empty
      count = natures.count
      expect(json.size).to eq count
      count.times do |index|
        expect(json[index][:name]).to eq(natures[index].name)
        expect(json[index][:traits]).to eq(natures[index].traits)
        expect(json[index][:modifiers]).to eq(natures[index].modifiers)
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /natures/:id' do
    let(:nature) { natures.sample }
    let(:nature_id) { nature.id }

    before(:each) do
      get "/natures/#{nature_id}"
    end

    context 'when the record exists' do
      it 'returns the nature' do
        expect(json).not_to be_empty
        expect(json[:name]).to eq(nature.name)
        expect(json[:traits].count).to eq(3)
        expect(json[:traits][:power]).to eq(nature.power)
        expect(json[:traits][:control]).to eq(nature.control)
        expect(json[:traits][:swiftness]).to eq(nature.swiftness)
        expect(json[:modifiers].count).to eq(4)
        expect(json[:modifiers][:strength]).to eq(nature.strength)
        expect(json[:modifiers][:constitution]).to eq(nature.constitution)
        expect(json[:modifiers][:dexterity]).to eq(nature.dexterity)
        expect(json[:modifiers][:intelligence]).to eq(nature.intelligence)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:nature_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Character::Nature with 'id'=100")
      end
    end
  end
end