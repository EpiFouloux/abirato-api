require 'rails_helper'

RSpec.describe Character::Event, type: :model do
  let(:instance) { create(:character_instance) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :character_instance_id }
    it { is_expected.to validate_presence_of :event_date }
    it { is_expected.to validate_presence_of :event_type }
  end

  describe 'factories' do
    context 'default factory' do
      it 'should be valid' do
        expect { create(:character_event) }.not_to raise_error
      end
    end

    context 'factory with specific instance' do

      it 'should be valid' do
        expect { create(:character_event, character_instance_id: instance.id) }.not_to raise_error
      end
    end

    context 'factory with data' do
      it 'should be valid' do
        expect { create(:character_event, event_data: { amount: 100 }) }.not_to raise_error
      end
    end
  end

  context 'saving a character instance' do

    it 'should create a change event' do
      expect(Character::Event.count).to eq(0)
      name = instance.name
      instance.name = 'foooooo'
      expect { instance.save! }.to change { Character::Event.count }.by(1)
      event = Character::Event.first
      expect(event).to eq(instance.events.first)
      expect(event).to have_attributes(
        character_instance_id: instance.id,
        event_type: Character::Event::CHANGED_ATTRIBUTES,
        event_data:
        {
          name: [name, 'foooooo']
        }.stringify_keys
      )
    end
  end

  context 'creating a add experience event' do

    it 'should increase instance experience' do
      xp = instance.experience_amount
      expect(instance.level).to eq(1)
      create(
        :character_event,
        character_instance_id: instance.id,
        event_type: Character::Event::EXPERIENCE_TYPE,
        event_data: {
          amount: 100
        }
      )
      expect(instance.reload.experience_amount).to eq(100 + xp)
    end

    it 'should increase instance experience and level if enough' do
      xp = instance.experience_amount
      expect(instance.level).to eq(1)
      create(
          :character_event,
          character_instance_id: instance.id,
          event_type: Character::Event::EXPERIENCE_TYPE,
          event_data: {
              amount: 1000
          }
      )
      expect(instance.reload.experience_amount).to eq(1000 + xp)
      expect(instance.level).to eq(3)
    end
  end
end
