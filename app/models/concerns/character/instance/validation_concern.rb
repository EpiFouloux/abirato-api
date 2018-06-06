module Character::Instance::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Relations

    belongs_to :user
    belongs_to :template, class_name: "Template", foreign_key: 'character_template_id'
    belongs_to :nature, class_name: "Nature", foreign_key: 'character_nature_id'
    belongs_to :special_class, class_name: "Class", foreign_key: 'character_special_class_id'
    belongs_to :prestigious_class, class_name: "Class", foreign_key: 'character_prestigious_class_id', required: false
    belongs_to :legendary_class, class_name: "Class", foreign_key: 'character_legendary_class_id', required: false

    has_many :events, class_name: "Event", foreign_key: "character_instance_id", dependent: :destroy

    # Basic validations

    validates :name, presence: true, length: { minimum: 5, maximum: 15 }
    validates :level, presence: true, inclusion: 1..29
    validates :experience_amount, presence: true

    # Self caracterstics

    validates :additive_power, presence: true
    validates :additive_swiftness, presence: true
    validates :additive_control, presence: true
    validates :additive_strength, presence: true
    validates :additive_constitution, presence: true
    validates :additive_dexterity, presence: true
    validates :additive_intelligence, presence: true
    validates :grown_strength, presence: true
    validates :grown_constitution, presence: true
    validates :grown_dexterity, presence: true
    validates :grown_intelligence, presence: true

    # Relation helpers

    validate :valid_traits_count
    validate :valid_modifiers_count
  end

  class_methods do
    TRAITS_COUNT = Character::Nature::TRAITS_COUNT
    MODIFIERS_COUNT = Character::Nature::MODIFIERS_COUNT
  end

  private

  def valid_traits_count
    errors.add(:traits, "count can not be different than #{TRAITS_COUNT}") unless traits.count == TRAITS_COUNT
  end

  def valid_modifiers_count
    errors.add(:modifiers, "count can not be different than #{MODIFIERS_COUNT}") unless modifiers.count == MODIFIERS_COUNT
  end
end
