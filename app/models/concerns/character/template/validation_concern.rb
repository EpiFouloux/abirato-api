# frozen_string_literal: true

module Character::Template::ValidationConcern
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :skill_one_id, presence: true
    validates :skill_two_id, presence: true
    validates :skill_three_id, presence: true

    validates_uniqueness_of :name
    validates_uniqueness_of :icon_id
    validates_uniqueness_of :picture_id

    validate do
      skills.each do |key1, value1|
        skills.each do |key2, value2|
          next if value1.nil?
          same_templates = Character::Template.where("#{key2}_id = #{value1}")
          errors.add(key1, "is not unique !") unless same_templates.count == 0 ||
                                                     (same_templates.count == 1 && same_templates.first == self)
        end
      end
    end
  end

  class_methods do
    SKILL_ID_KEYS = %i[
      skill_one_id
      skill_two_id
      skill_three_id
    ].freeze
  end
end
