class Character::Nature < ApplicationRecord
	include Character::Nature::ValidationConcern

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
