module Character::Instance::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Basic validations

    validates :name,                  presence: true, length: { minimum: 5, maximum: 15 }
    validates :level,                 presence: true, inclusion: 0..29
    validates :experience_amount,     presence: true

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
      errors.add(:level, "does not match the associated class category: level: #{level}, class category: #{class_category}") if level < CLASS_CATEGORIES_LEVEL_MIN[class_category.to_i]
    end

    # Experience and level
    validate do
      errors.add(:level, "Do not match the character experience amount") unless level == self.class.target_level(experience_amount)
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
