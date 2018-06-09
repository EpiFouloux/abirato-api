# frozen_string_literal: true

module Character::Template::ValidationConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :nature, class_name: 'Nature', foreign_key: 'character_nature_id'

    validates :name, presence: true
    validates_uniqueness_of :name
    validates_uniqueness_of :icon_id
    validates_uniqueness_of :picture_id

    validates_uniqueness_of :skill_one_id
    validates_uniqueness_of :skill_two_id
    validates_uniqueness_of :skill_three_id
  end

  class_methods do
    SKILL_ID_KEYS = %i[
      skill_one_id
      skill_two_id
      skill_three_id
    ].freeze
  end
end
