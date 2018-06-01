class User < ApplicationRecord
	has_many :character_instances, dependent: :destroy, class_name: "Character::Instance"

	validates :name, presence: true
	validates :email, presence: true
end
