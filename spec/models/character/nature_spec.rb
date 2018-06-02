require 'rails_helper'

RSpec.describe Character::Nature, type: :model do

	describe 'validations' do
		
		it { is_expected.to validate_presence_of(:name) }
		
		it { is_expected.to validate_presence_of(:power) }
		it { is_expected.to validate_presence_of(:control) }
		it { is_expected.to validate_presence_of(:swiftness) }

		it { is_expected.to validate_presence_of(:constitution) }
		it { is_expected.to validate_presence_of(:strength) }
		it { is_expected.to validate_presence_of(:dexterity) }
		it { is_expected.to validate_presence_of(:intelligence) }

		context 'traits validations' do
			

		end
	end
end
