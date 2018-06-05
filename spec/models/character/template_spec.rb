require 'rails_helper'

RSpec.describe Character::Template, type: :model do
  describe 'basic validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to belong_to(:nature) }
  end

  describe 'factories' do
    context 'a correct factory' do
      it 'should be valid' do
        expect { create(:character_template) }.not_to raise_error
      end
    end

    context 'uniqueness' do
      let!(:nature) { create(:character_nature) }
      let!(:template) { create(:character_template, nature: nature, name: 'foo') }

      it 'should raise error with the same name' do
        expect {
          create(
            :character_template,
            nature: nature,
            picture_id: template.picture_id + 1,
            icon_id: template.icon_id + 1,
            name: template.name
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Name has already been taken/)
      end

      it 'should raise error with the same picture' do
        expect {
          create(
              :character_template,
              nature: nature,
              picture_id: template.picture_id,
              icon_id: template.icon_id + 1,
              name: 'bar'
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Picture has already been taken/)
      end

      it 'should raise error with the same icon' do
        expect {
          create(
              :character_template,
              nature: nature,
              picture_id: template.picture_id + 1,
              icon_id: template.icon_id,
              name: 'bar'
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Icon has already been taken/)
      end

      it 'should raise error with the same skill' do
        expect {
          create(
              :character_template,
              nature: nature,
              picture_id: template.picture_id + 1,
              icon_id: template.icon_id + 1,
              name: 'bar',
              skill_one_id: template.skill_one_id
          )
        } .to raise_error(ActiveRecord::RecordInvalid, /Skill one has already been taken/)
      end
    end
  end
end
