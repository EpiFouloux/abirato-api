require 'rails_helper'

RSpec.describe Character::Instance, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:template) }
    it { is_expected.to have_many(:events).dependent(:destroy) }
    it { is_expected.to belong_to(:nature) }
    it { is_expected.to belong_to(:special_class) }
    it { is_expected.to belong_to(:prestigious_class) }
    it { is_expected.to belong_to(:legendary_class) }
  end
end
