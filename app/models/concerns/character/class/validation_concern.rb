# frozen_string_literal: true

module Character::Class::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Relations
    validates :name, presence: true
    validates :power, presence: true
    validates :control, presence: true
    validates :swiftness, presence: true
    validates :class_type, presence: true, inclusion: { in: CLASS_CATEGORIES }

    # no duplicates
    validates_uniqueness_of :name
    validates_uniqueness_of :skill_id

    validate :unique_traits
    validate :valid_type
  end

  class_methods do
    SPECIAL     = 0
    PRESTIGIOUS = 1
    LEGENDARY   = 2
    CLASS_CATEGORIES = [
        SPECIAL,
        PRESTIGIOUS,
        LEGENDARY
    ].freeze
  end

  def unique_traits
    count = Character::Class.where(power: power, control: control, swiftness: swiftness).count
    errors.add(:traits, 'already exist in database') unless count == 0
  end

  def valid_type
    expected_type = class_category
    errors.add(:class_type, "does not match the asociated traits") if expected_type == nil || class_type != expected_type
  end
end
