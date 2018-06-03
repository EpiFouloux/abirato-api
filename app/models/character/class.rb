# frozen_string_literal: true

class Character::Class < ApplicationRecord
  include Character::Class::ValidationConcern

  def traits
    {
      power:      power,
      control:    control,
      swiftness:  swiftness
    }
  end
end
