require 'rails_helper'

RSpec.describe Character::Event, type: :model do

	describe 'validations' do
		
		it { is_expected.to belong_to(:character_instance) }
	end
end
