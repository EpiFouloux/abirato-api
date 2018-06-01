require 'rails_helper'

RSpec.describe Character::Template, type: :model do

	context 'validations' do
		
		it { is_expected.to validate_presence_of(:name) }
		it { is_expected.to belong_to(:character_nature) }
	end
end
