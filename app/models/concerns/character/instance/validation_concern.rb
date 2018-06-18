module Character::Instance::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Basic validations

    validates :name,                  presence: true, length: { minimum: 5, maximum: 15 }
    validates :level,                 presence: true, inclusion: 1..29
    validates :experience_amount,     presence: true
    validates :waiting_trait,         inclusion: [true, false]

    # Self characteristics

    validates :additive_power,        presence: true
    validates :additive_swiftness,    presence: true
    validates :additive_control,      presence: true
    validates :additive_strength,     presence: true
    validates :additive_constitution, presence: true
    validates :additive_dexterity,    presence: true
    validates :additive_intelligence, presence: true
    validates :grown_strength,        presence: true
    validates :grown_constitution,    presence: true
    validates :grown_dexterity,       presence: true
    validates :grown_intelligence,    presence: true

    # validation helpers

    # Class category
    validate do
      expected_category = class_category
      errors.add(:traits, "do not match any class category") if expected_category.nil?
      errors.add(:traits, "do not match the associated current class") if current_class&.class_category != expected_category
    end

    # Class and level
    validate do
      if level < CLASS_CATEGORIES_LEVEL_MIN[class_category.to_i]
        errors.add(:level, "does not match the associated class category: level: #{level}, class category: #{class_category}")
        errors.add(:level, "doesn't allow the character to be waiting for a trait") if waiting_trait
      elsif level >= CLASS_CATEGORIES_LEVEL_MIN[class_category.to_i + 1]
        errors.add(:level, "is too high for current traits, should be awaiting a new trait") unless waiting_trait
      end
    end
  end

  class_methods do
    TRAITS_COUNT = Character::Nature::TRAITS_COUNT.freeze
    MODIFIERS_COUNT = Character::Nature::MODIFIERS_COUNT.freeze

    CLASS_CATEGORIES_LEVEL_MIN = [
      0,
      10,
      20
    ].freeze
  end
end
