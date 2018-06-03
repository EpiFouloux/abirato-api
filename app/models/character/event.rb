class Character::Event < ApplicationRecord
  belongs_to :character_instance, class_name: "Instance"
end
