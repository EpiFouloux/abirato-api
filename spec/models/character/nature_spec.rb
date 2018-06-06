require 'rails_helper'

RSpec.describe Character::Nature, type: :model do

  describe 'default validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:power) }
    it { is_expected.to validate_presence_of(:control) }
    it { is_expected.to validate_presence_of(:swiftness) }

    it { is_expected.to validate_presence_of(:constitution) }
    it { is_expected.to validate_presence_of(:strength) }
    it { is_expected.to validate_presence_of(:dexterity) }
    it { is_expected.to validate_presence_of(:intelligence) }
  end

  describe 'Traits validations' do
    let(:nature) { Character::Nature.all.sample }

    after(:each) do
      expect { nature.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should fail without any traits' do
      nature.power = 0
      nature.control = 0
      nature.swiftness = 0
    end

    it 'should fail with huge traits' do
      nature.power = 10
      nature.control = 10
      nature.swiftness = 10
    end

    it 'should fail with nil traits' do
      nature.power = nil
    end
  end

end
