class Character::Instance < ApplicationRecord
	belongs_to :user
	belongs_to :character_template, class_name: "Template"
	belongs_to :character_nature, class_name: "Nature"
	belongs_to :character_class, class_name: "Class"

	has_many :character_events,
	  class_name: "Event",
	  foreign_key: "character_instance_id",
	  dependent: :destroy

	validates :name, presence: true
end
