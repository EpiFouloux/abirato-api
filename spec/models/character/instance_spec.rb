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

  describe 'methods' do
    let!(:instance) { create(:character_instance) }

    context '#current_class' do
      it 'should return the special class for a starting character' do
        expect(instance.current_class).to eq(instance.special_class)
      end

      it 'should return the prestigious class for a leveled character' do
        instance.prestigious_class = create(:prestigious_class)
        instance.save!(validate: false)
        expect(instance.current_class).to eq(instance.prestigious_class)
      end
    end

    context '#classes' do
      it 'should return the special class for a starting character' do
        expect(instance.classes.count).to eq(1)
        expect(instance.classes.first).to eq(instance.special_class)
      end

      it 'should return two classes for a leveled character' do
        instance.prestigious_class = create(:prestigious_class)
        instance.save!(validate: false)
        expect(instance.classes.count).to eq(2)
        expect(instance.classes.first).to eq(instance.special_class)
        expect(instance.classes.last).to eq(instance.prestigious_class)
      end
    end
  end
end
