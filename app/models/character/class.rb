# frozen_string_literal: true

class Character::Class < ApplicationRecord
  include Character::Traits
  include Character::Class::ValidationConcern

  def traits
    {
      power:      power,
      control:    control,
      swiftness:  swiftness
    }
  end

  class << self
    def find_by_traits(traits)
      Character::Class.where(
        power:      traits[:power],
        control:    traits[:control],
        swiftness:  traits[:swiftness]
      ).first
    end
  end
end
