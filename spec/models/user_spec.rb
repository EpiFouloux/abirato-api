require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'basic validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_presence_of(:level) }
    it { is_expected.to validate_presence_of(:experience_amount) }
    it { is_expected.to have_many(:character_instances).dependent(:destroy) }
  end

  describe 'factories' do
    context 'a valid factory' do
      it 'should be correct' do
        expect { create(:user) }.not_to raise_error
      end
    end

    context 'with invalid parameters' do
      it 'should raise and error' do
        expect { create(:user, level: nil, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

end
