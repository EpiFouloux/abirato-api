# frozen_string_literal: true

module Character::Class::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Relations
    validates :name, presence: true
    validates :power, presence: true
    validates :control, presence: true
    validates :swiftness, presence: true
    validates :type, presence: true, inclusion: { in: CLASS_CATEGORIES }

    # no duplicates
    validates_uniqueness_of :name

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
    count = Character::Class.where(traits: traits).count
    errors.add(:traits, 'already exist in database') unless count == 0
  end

  def valid_type
    sum = 0
    traits.each do |key, value|
      sum += value.to_i # to_i transforms nil to 0
    end
    errors.add(:traits, "amount is too small (#{sum})") if sum <= Character::Nature::TRAITS_SUM
    sum -= Character::Nature::TRAITS_SUM
    errors.add(:traits, "amount is incorrect (#{sum})") unless CLASS_CATEGORIES.include? sum
    expected_type = CLASS_CATEGORIES[sum]
    errors.add(:type, "does not match the asociated traits (#{sum})") if type != expected_type
  end
end
