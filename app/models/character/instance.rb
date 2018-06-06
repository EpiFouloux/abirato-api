class Character::Instance < ApplicationRecord

  include Character::TraitsConcern
  included Character::ModifiersConcern
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

  # Skills

  def skill_ids
    res = []
    classes.each do |c|
      res << c.skill_id
    end
    res << template&.skill_ids
  end

  def skills
    res = {}
    res.merge!(template.skills)
    res[:skill_four] = special_class.skill_id
    res[:skill_five] = prestigious_class&.skill_id
    res[:skill_six] = legendary_class&.skill_id
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
end
