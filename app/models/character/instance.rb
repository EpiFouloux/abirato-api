class Character::Instance < ApplicationRecord
  include Character::Traits
  included Character::Modifiers
  include Character::Instance::ValidationConcern
  include Character::Instance::RelationsConcern

  before_validation :handle_traits

  def handle_traits
    target_class = Character::Class.find_by_traits(traits)
    return if target_class.nil?
    if current_class.nil?
      self.special_class = target_class
      return
    end
    return if target_class == current_class
    case current_class.class_type
    when Character::Class::SPECIAL
      self.prestigious_class = target_class
    when Character::Class::PRESTIGIOUS
      self.legendary_class = target_class
    else
      raise ActiveRecord::RecordInvalid, "The class category is invalid"
    end
  end

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
