require 'rails_helper'

RSpec.describe Character::Template, type: :model do
  describe 'basic validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:skill_one_id) }
    it { is_expected.to validate_presence_of(:skill_two_id) }
    it { is_expected.to validate_presence_of(:skill_three_id) }
    it { is_expected.to belong_to(:nature) }
  end

  describe 'factories' do
    context 'a correct factory' do
      it 'should be valid' do
        expect { create(:character_template) }.not_to raise_error
      end
    end

    context 'uniqueness' do
      let!(:nature) { Character::Nature.first }
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
        } .to raise_error(ActiveRecord::RecordInvalid, /Skill one is not unique/)
      end
    end
  end

  describe 'methods' do
    let(:template) { create(:character_template) }

    context 'skill ids' do
      it 'should return correct skill_ids' do
        ids = template.skill_ids
        expect(ids.count).to eq(3)
        ids.each do |id|
          expect(id).not_to be_nil
        end
      end
    end

    context 'skills' do
      it 'should return correct skills' do
        skills = template.skills
        expect(skills.keys.count).to eq(3)
        expect(skills[:skill_one]).not_to be_nil
        expect(skills[:skill_two]).not_to be_nil
        expect(skills[:skill_three]).not_to be_nil
      end
    end
  end
end
