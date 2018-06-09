module Character::Modifiers
  extend ActiveSupport::Concern

  included do
    validate do
      errors.add(:modifiers, "count can not be different than #{MODIFIERS_COUNT}") unless modifiers.count == MODIFIERS_COUNT
    end
    validate do
      errors.add(:modifiers, "amount can not be inferior than #{MODIFIERS_MINIMUM_SUM}") unless modifiers_sum >= MODIFIERS_MINIMUM_SUM
      errors.add(:modifiers, "amount can not be superior than #{MODIFIERS_MAXIMUM_SUM}") unless modifiers_sum < MODIFIERS_MAXIMUM_SUM
    end
  end

  class_methods do
    MODIFIERS_COUNT = 4
    MODIFIERS_MINIMUM_SUM = 5
    MODIFIERS_MAXIMUM_SUM = 40 # fill with correct value

    STRENGTH = 'strength'.freeze
    CONSTITUTION = 'constitution'.freeze
    DEXTERITY = 'dexterity'.freeze
    INTELLIGENCE = 'intelligence'.freeze

    MODIFIERS_NAMES = [
      STRENGTH,
      CONSTITUTION,
      DEXTERITY,
      INTELLIGENCE
    ].freeze
  end

  # Helpers

  def modifiers_sum
    sum = 0
    modifiers.each do |key, value|
      sum += value.to_i  unless value.nil?
    end
    sum
  end
end