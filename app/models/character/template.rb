class Character::Template < ApplicationRecord
	belongs_to :character_nature, class_name: "Nature"

	validates :name, presence: true
end
