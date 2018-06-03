module Character::Instance::ValidationConcern
  extend ActiveSupport::Concern

  included do
    # Relations

    belongs_to :user
    belongs_to :character_template, class_name: "Template"
    belongs_to :character_nature, class_name: "Nature"
    belongs_to :character_class, class_name: "Class"

    has_many :character_events, class_name: "Event", foreign_key: "character_instance_id", dependent: :destroy

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
