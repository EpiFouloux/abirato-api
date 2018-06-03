# frozen_string_literal: true

class Character::Class < ApplicationRecord

  validates :name, presence: true
  validates :power, presence: true
  validates :control, presence: true
  validates :swiftness, presence: true

  class << self
    SPECIAL     = 0
    PRESTIGIOUS = 1
    LEGENDARY   = 2
    CLASS_CATEGORIES = [
        SPECIAL,
        PRESTIGIOUS,
        LEGENDARY
    ]
  end
end
