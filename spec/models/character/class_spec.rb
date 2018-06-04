require 'rails_helper'

RSpec.describe Character::Class, type: :model do
  describe 'basic validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :power }
    it { is_expected.to validate_presence_of :control }
    it { is_expected.to validate_presence_of :swiftness }
    it { is_expected.to validate_presence_of :class_type }
  end

  describe 'factories' do
    context 'a correct factory' do
      it 'should be valid' do
        expect { create(:character_class) }.not_to raise_error
      end
    end

    context 'with the wrong amount of traits' do
      it 'should raise_error with negative amount' do
        expect {
          create(
            :character_class,
            power:      0,
            swiftness:  -10,
            control:    0
          )
        } .to raise_error(ActiveRecord::RecordInvalid)
      end
      it 'should raise_error with too big amount' do
        expect {
          create(
            :character_class,
            power:      0,
            swiftness:  10,
            control:    100
          )
        } .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with the wrong class_type ' do
      it 'should raise_error' do
        expect {
          create(
            :character_class,
            power:      1,
            swiftness:  2,
            control:    3,
            class_type: Character::Class::SPECIAL
          )
        } .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the class is not unique' do
      let!(:class1) { create(:character_class, name: 'foobar', skill_id: 0) }

      it 'should raise_error with same name' do
        expect {
          create(
            :character_class,
            name: class1.name,
            skill_id: 1
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Name has already been taken/)
      end
      it 'should raise_error with same skill' do
        expect {
          create(
            :character_class,
            name: 'hello',
            skill_id: class1.skill_id
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Skill has already been taken/)
      end
      it 'should raise_error with same traits' do
        expect {
          create(
            :character_class,
            name: 'hello',
            power: class1.power,
            control: class1.control,
            swiftness: class1.swiftness,
            skill_id: 1
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Traits already exist in database/)
      end
    end
  end
end
