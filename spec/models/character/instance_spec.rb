require 'rails_helper'

RSpec.describe Character::Instance, type: :model do

  describe 'basic validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:template) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to belong_to(:nature) }
    it { is_expected.to belong_to(:special_class) }
    it { is_expected.to belong_to(:prestigious_class) }
    it { is_expected.to belong_to(:legendary_class) }
  end

  describe 'factories' do

    context 'a valid factory' do

      it 'should be valid' do
        expect { create(:character_instance) }.not_to raise_error
      end
    end
  end
end
