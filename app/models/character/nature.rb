# frozen_string_literal: true

class Character::Nature < ApplicationRecord
  include Character::Traits
  include Character::Modifiers
  include Character::Nature::ValidationConcern
  include Character::Nature::RelationsConcern

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
      power:     power,
      control:   control,
      swiftness:  swiftness,
    }
  end
end
