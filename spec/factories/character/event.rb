# frozen_string_literal: true

FactoryBot.define do
  factory :character_event, class: Character::Event do
    character_instance_id   { create(:character_instance).id }
    event_date              { Time.now }
    event_type              { Character::Event::EVENT_TYPES.sample }
    event_data              { }
  end
end
