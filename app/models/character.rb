class Character < ApplicationRecord

  belongs_to :user

  has_one :nature
  has_one :character_class
  has_one :template_character
  has_many :character_events

  validate :valid_traits

  private

  def valid_traits
  	
  end
end
