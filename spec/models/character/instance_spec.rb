require 'rails_helper'

RSpec.describe Character::Instance, type: :model do

	context 'validations' do
		
		it { is_expected.to validate_presence_of(:name) }
		it { is_expected.to belong_to(:user) }
		it { is_expected.to belong_to(:character_template) }
		it { is_expected.to have_many(:character_events).dependent(:destroy) }
		it { is_expected.to belong_to(:character_nature) }
		it { is_expected.to belong_to(:character_class) }
	end
end
