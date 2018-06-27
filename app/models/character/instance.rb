class Character::Instance < ApplicationRecord
  include Character::Traits
  include Character::Modifiers
  include Character::Instance::ValidationConcern
  include Character::Instance::RelationsConcern

  before_validation :handle_traits
  before_validation :handle_experience_amount, if: :experience_amount_changed?
  before_save       :log_changed_attributes

  # helpers

  def waiting_trait?
    level >= CLASS_CATEGORIES_LEVEL_MIN[class_category.to_i + 1]
  end

  def waiting_modifier?
    level >= ADDITIVE_MODIFIER_LEVELS[additive_modifiers_sum]
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

  def additive_modifiers
    {
      constitution:   additive_constitution,
      strength:       additive_strength,
      dexterity:      additive_dexterity,
      intelligence:   additive_intelligence
    }
  end

  def traits
    {
      power:      power,
      control:    control,
      swiftness:  swiftness
    }
  end

  def additive_modifiers_sum
    sum = 0
    additive_modifiers.each do |key, value|
      sum += value.to_i unless value.nil?
    end
    sum
  end

  # Traits

  def power
    (nature&.power).to_i + additive_power.to_i
  end

  def control
    (nature&.control).to_i + additive_control.to_i
  end

  def swiftness
    (nature&.swiftness).to_i + additive_swiftness.to_i
  end

  # Modifiers

  def constitution
    (nature&.constitution).to_i + additive_constitution.to_i
  end

  def strength
    (nature&.strength).to_i + additive_strength.to_i
  end

  def intelligence
    (nature&.intelligence).to_i + additive_intelligence.to_i
  end

  def dexterity
    (nature&.dexterity).to_i + additive_dexterity.to_i
  end

  class << self
    # Experience

    def target_experience(target_level)
      ((target_level**2) * 100).to_i
    end

    def target_level(target_xp)
      return 0 if target_xp.nil?
      Math.sqrt(target_xp / 100).to_i
    end
  end

  private

  def handle_traits
    if class_category.nil?
      errors.add(:traits, "must have at least one additive trait")
      return false
    end
    target_class = Character::Class.find_by_traits(traits)
    return if target_class == current_class
    category = target_class.class_category
    self[class_keys[category]] = target_class.id
    category += 1
    (category..Character::Class::LEGENDARY).each do |i|
      self[class_keys[i]] = nil
    end
  end

  def handle_experience_amount
    self.level = self.class.target_level(self.experience_amount)
  end

  def log_changed_attributes
  end
end
