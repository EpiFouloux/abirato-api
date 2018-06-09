require 'rails_helper'

RSpec.describe Character::Class, type: :model do
  describe 'basic validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :power }
    it { is_expected.to validate_presence_of :control }
    it { is_expected.to validate_presence_of :swiftness }
    it { is_expected.to validate_presence_of :class_type }
  end

  describe 'complex validations' do
    let(:special_class) { Character::Class.special_classes.sample }

    context 'with the wrong amount of traits' do
      it 'should raise_error with negative amount' do
        special_class.power = -1
        expect { special_class.save! } .to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'should raise_error with too big amount' do
        special_class.power = 100
        expect { special_class.save! } .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with the wrong class_type ' do
      it 'should raise_error' do
        special_class.class_type = 1 # prestigious
        expect { special_class.save! } .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the class is not unique' do
      before(:each) do
        special_class
      end

      it 'should raise_error with same name' do
        expect {
          create(
            :special_class,
            name: special_class.name,
            skill_id: 1
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Name has already been taken/)
      end

      it 'should raise_error with same skill' do
        expect {
          create(
            :special_class,
            name: 'hello',
            skill_id: special_class.skill_id
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Skill has already been taken/)
      end

      it 'should raise_error with same traits' do
        expect {
          create(
            :special_class,
            name: 'hello',
            power: special_class.power,
            control: special_class.control,
            swiftness: special_class.swiftness,
            skill_id: 1
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Traits already exist in database/)
      end
    end
  end
end
