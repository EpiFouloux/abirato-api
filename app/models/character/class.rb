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

    def special_classes
      Character::Class.where(class_type: 0)
    end

    def prestigious_classes
      Character::Class.where(class_type: 1)
    end

    def legendary_classes
      Character::Class.where(class_type: 2)
    end
  end
end
