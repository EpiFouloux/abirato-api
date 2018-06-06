class Character::Instance < ApplicationRecord
  include Character::Instance::ValidationConcern

  # helpers

  def current_class
    classes.last
  end

  def classes
    [
      special_class,
      prestigious_class,
      legendary_class
    ].compact
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
    (nature&.constitution).to_i + additive_constitution
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

  # Skills

  def skill_ids
    res = [
      current_class&.skill_id
    ]
    res << template&.skill_ids
  end

  def skills
    res = {
      skill_four: current_class&.skill_id
    }
    res.merge!(template.skills)
  end

  # Global accessors

  def modifiers
    {
      constitution:   constitution,
      strength:       strength,
      dexterity:      dexterity,
      intelligence:   intelligence
    }
  end

  def traits
    {
      power:      power,
      control:    control,
      swiftness:  swiftness,
    }
  end
end
