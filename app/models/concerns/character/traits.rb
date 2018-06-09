# frozen_string_literal: true

module Character::Traits
  extend ActiveSupport::Concern

  included do
    validate do
      sum = traits_sum
      errors.add(:traits, "amount is too small (#{sum})") if sum < TRAITS_MINIMUM_SUM
      errors.add(:traits, "amount is too big (#{sum})") if sum > TRAITS_MAXIMUM_SUM
    end
    validate do
      errors.add(:traits, "count can not be different than #{TRAITS_COUNT}") unless traits.count == TRAITS_COUNT
    end
  end

  class_methods do
    TRAITS_COUNT = 3
    TRAITS_MINIMUM_SUM = 3
    TRAITS_MAXIMUM_SUM = 6

    POWER = 'power'
    CONTROL = 'control'
    SWIFTNESS = 'swiftness'

    TRAITS_NAMES = [
      POWER,
      CONTROL,
      SWIFTNESS
    ].freeze
  end

  # helpers

  def traits_sum
    sum = 0
    traits.each do |key, value|
      sum += value unless value.nil?
    end
    sum
  end

  def class_category
    sum = traits_sum - TRAITS_MINIMUM_SUM
    return nil if sum <= 0 || sum > Character::Class::CLASS_CATEGORIES.count
    Character::Class::CLASS_CATEGORIES[sum - 1]
  end
end