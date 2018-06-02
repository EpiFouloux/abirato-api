module Character::BasicStatsValidationConcern
	extend ActiveSupport::Concern

	included do
		validate :valid_traits_sum
		validate :valid_traits_value
		validate :valid_modifiers_sum
		validate :valid_modifiers_value
	end

	class_methods do
		MAX_TRAITS_SUM = 		3.freeze
		MAX_TRAITS_VALUE = 		2.freeze
		MAX_MODIFIERS_SUM = 	5.freeze
		MAX_MODIFIERS_VALUE = 	3.freeze

	end

	private

	def valid_traits_sum
		sum = 0
		traits.each do |key, value|
			sum += value
		end
		errors.add(:traits, "total can not be greater than #{MAX_TRAITS_SUM}") if sum > MAX_TRAITS_SUM
	end


	def valid_traits_value
		traits.each do |key, value|
			errors.add(key, "can not be greater than #{MAX_TRAITS_VALUE}") if value > MAX_TRAITS_VALUE
		end
	end

	def valid_modifiers_sum
		sum = 0
		modifiers.each do |key, value|
			sum += value
		end
		errors.add(:traits, "total can not be greater than #{MAX_MODIFIERS_SUM}") if sum > MAX_MODIFIERS_SUM
	end


	def valid_modifiers_value
		modifiers.each do |key, value|
			errors.add(key, "can not be greater than #{MAX_MODIFIERS_VALUE}") if value > MAX_MODIFIERS_VALUE
		end
	end
end