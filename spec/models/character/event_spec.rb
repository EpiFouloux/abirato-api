require 'rails_helper'

RSpec.describe Character::Event, type: :model do

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
      let(:instance) { create(:character_instance) }

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
end
