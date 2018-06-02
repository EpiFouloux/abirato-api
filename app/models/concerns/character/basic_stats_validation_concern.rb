module Character::BasicStatsValidationConcern
	extend ActiveSupport::Concern

	included do
		# Nature name
		validates :name, presence: true

		# Nature Traits
		validates :power, presence: true
		validates :control, presence: true
		validates :swiftness, presence: true

		# Nature Modifiers
		validates :strength, presence: true
		validates :constitution, presence: true
		validates :dexterity, presence: true
		validates :intelligence, presence: true

		# Complex Verifications
		validate :valid_traits_sum
		validate :valid_traits_value
		validate :valid_modifiers_sum
		validate :valid_modifiers_value
	end

	class_methods do
		TRAITS_SUM = 			3.freeze
		MAX_TRAITS_VALUE = 		2.freeze
		MODIFIERS_SUM = 		5.freeze
		MAX_MODIFIERS_VALUE = 	3.freeze
	end

	private

	def valid_traits_sum
		sum = 0
		traits.each do |key, value|
			sum += value unless value.nil?
		end
		errors.add(:traits, "total can not be different than #{TRAITS_SUM}") if sum != TRAITS_SUM
	end


	def valid_traits_value
		traits.each do |key, value|
			errors.add(key, "can not be inferior to 0 or greater than #{MAX_TRAITS_VALUE}") unless (0..MAX_TRAITS_VALUE).include? value
		end
	end

	def valid_modifiers_sum
		sum = 0
		modifiers.each do |key, value|
			sum += value unless value.nil?
		end
		errors.add(:traits, "total can not be different than #{MODIFIERS_SUM}") if sum != MODIFIERS_SUM
	end


	def valid_modifiers_value
		modifiers.each do |key, value|
			errors.add(key, "can not be inferior to 0 or greater than #{MAX_MODIFIERS_VALUE}")  unless (0..MAX_MODIFIERS_VALUE).include? value
		end
	end
end