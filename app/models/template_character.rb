class TemplateCharacter < ApplicationRecord

	has_one :nature

	validates :name, presence: true
end
