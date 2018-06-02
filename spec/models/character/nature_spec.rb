require 'rails_helper'

RSpec.describe Character::Nature, type: :model do

	describe 'factories' do
		
		it 'default factory should be valid' do
			expect { create(:character_nature) }.not_to raise_error
		end

		it 'wrong values should fail' do
			expect { create(:character_nature, power: 10) }.to raise_error(
				ActiveRecord::RecordInvalid,
				 /Validation failed: Traits total can not be different than 3, Power can not be inferior to 0 or greater than 2/
			)
		end
	end

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
		
		let(:nature) { create(:character_nature) }

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
