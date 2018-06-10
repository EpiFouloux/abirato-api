require 'rails_helper'

RSpec.describe 'Character Templates API', type: :request do
  let (:templates) { Character::Template.all }

  describe 'GET /templates' do

    before(:each) do
      get "/templates"
    end

    it 'returns templates' do
      expect(json).not_to be_empty
      count = templates.count
      expect(json.size).to eq count
      count.times do |index|
        expect(json[index][:name]).to eq(templates[index].name)
        expect(json[index][:icon]).to eq(templates[index].icon_id)
        expect(json[index][:picture]).to eq(templates[index].picture_id)
        expect(json[index][:skills]).to eq(templates[index].skills)
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /templates/:id' do
    let(:template) { templates.sample }
    let(:template_id) { template.id }

    before(:each) do
      get "/templates/#{template_id}"
    end

    context 'when the record exists' do
      it 'returns the template' do
        expect(json).not_to be_empty
        expect(json[:name]).to eq(template.name)
        expect(json[:skills].count).to eq(3)
        expect(json[:skills]).to eq(template.skills)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:template_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Character::Template with 'id'=100")
      end
    end
  end
end