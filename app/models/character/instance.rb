class Character::Instance < ApplicationRecord
  include Character::Instance::ValidationConcern

  # helpers

  def template
    character_template
  end

  def nature
    character_nature
  end

  # Traits

  def power
    (nature&.power).to_i + additive_power
  end

  def control
    (nature&.control).to_i + additive_control
  end

  def swiftness
    (nature&.swiftness).to_i + additive_swiftness
  end

  # Modifiers

  def constitution
    (nature&.consitution).to_i + additive_constitution
  end

  def strength
    (nature&.strength).to_i + additive_strength
  end

  def intelligence
    (nature&.intelligence).to_i + additive_intelligence
  end

  def dexterity
    (nature&.dexterity).to_i + additive_dexterity
  end

  # Global accessors

  def modifiers
    {
      constitution:   constitution,
      strength:     strength,
      dexterity:     dexterity,
      intelligence:   intelligence
    }
  end

  def traits
    {
      power:     power,
      control:   control,
      swiftness:  swiftness,
    }
  end
end
