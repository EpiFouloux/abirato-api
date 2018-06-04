# frozen_string_literal: true

module Character::Nature::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Nature name
    validates :name, presence: true

    # Nature Traits
    validates :power, presence: true
    validates :control, presence: true
    validates :swiftness, presence: true

    # Nature Modifiers
    validates :strength, presence: true
    validates :constitution, presence: true
    validates :dexterity, presence: true
    validates :intelligence, presence: true

    # Helpers
    validate :valid_traits_count
    validate :valid_modifiers_count
    validate :unique_traits

    # Complex Verifications
    validate :valid_traits_sum
    validate :valid_traits_value
    validate :valid_modifiers_sum
    validate :valid_modifiers_value

    # No duplicates
    validates_uniqueness_of :name
  end

  class_methods do
    TRAITS_COUNT = 3
    TRAITS_SUM = 3
    MAX_TRAITS_VALUE = 2
    MODIFIERS_COUNT = 4
    MODIFIERS_SUM = 5
    MAX_MODIFIERS_VALUE = 3
  end

  private

  def unique_traits
    count = Character::Nature.where(power: power, control: control, swiftness: swiftness).count
    errors.add(:traits, 'already exist in database') unless count == 0
  end

  def valid_traits_count
    errors.add(:traits, "count can not be different than #{TRAITS_COUNT}") unless traits.count == TRAITS_COUNT
  end

  def valid_traits_sum
    sum = 0
    traits.each do |key, value|
      sum += value.to_i  unless value.nil?
    end
    errors.add(:traits, "total can not be different than #{TRAITS_SUM}") if sum != TRAITS_SUM
  end

  def valid_traits_value
    traits.each do |key, value|
      errors.add(key, "can not be inferior to 0 or greater than #{MAX_TRAITS_VALUE}") unless (0..MAX_TRAITS_VALUE).include? value
    end
  end

  def valid_modifiers_count
    errors.add(:modifiers, "count can not be different than #{MODIFIERS_COUNT}") unless modifiers.count == MODIFIERS_COUNT
  end

  def valid_modifiers_sum
    sum = 0
    modifiers.each do |key, value|
      sum += value.to_i  unless value.nil?
    end
    errors.add(:traits, "total can not be different than #{MODIFIERS_SUM}") if sum != MODIFIERS_SUM
  end

  def valid_modifiers_value
    modifiers.each do |key, value|
      errors.add(key, "can not be inferior to 0 or greater than #{MAX_MODIFIERS_VALUE}") unless (0..MAX_MODIFIERS_VALUE).include? value
    end
  end
end
