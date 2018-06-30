# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Character::EventsController, type: :request do
  describe 'GET /events' do

    let(:user) {create(:user)}
    let(:instance) { create(:character_instance, user: user) }

    context 'with out user' do
      it 'returns status code 422' do
        get "/characters/#{instance.id}/events"
        expect(response).to have_http_status(422)
      end
    end

    context 'with signed in user' do
      before(:each) do
        create(
            :character_event,
            character_instance_id: instance.id,
            event_type: Character::Event::EXPERIENCE_TYPE,
            event_data: {
              amount: 100
            }
        )
        get "/characters/#{instance.id}/events", headers: valid_headers
      end

      it 'returns character_classes' do
        expect(json).not_to be_empty
        count = instance.events.count
        expect(count).to eq(2) # experience change and changed attributes
        expect(json.count).to eq(count)
        expect(json.first).to include(
          character_instance_id:  instance.id,
          event_type:             Character::Event::EXPERIENCE_TYPE,
          event_data:             { amount: 100 }
        )
        expect(json.last).to include(
          character_instance_id:  instance.id,
          event_type:             Character::Event::CHANGED_ATTRIBUTES,
          event_data:             { experience_amount: [150, 250] }
        )
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end