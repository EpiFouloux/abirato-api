class Character::Nature < ApplicationRecord

	validates :name, presence: true

	validates :power, presence: true
	validates :control, presence: true
	validates :swiftness, presence: true

	validates :constitution, presence: true
	validates :strength, presence: true
	validates :dexterity, presence: true
	validates :intelligence, presence: true

	include Character::BasicStatsValidationConcern

	def modifiers
		{
			constitution: 	constitution,
			strength: 		strength,
			dexterity: 		dexterity,
			intelligence: 	intelligence
		}
	end

	def traits
		{
			power: 		power,
			control: 	control,
			swiftness:	swiftness,
		}
	end
end
