module Character::Event::ValidationConcern
  extend ActiveSupport::Concern

  included do
    validates :character_instance_id, presence: true
    validates :event_type, presence: true, inclusion: { in: EVENT_TYPES }
    validates :event_date, presence: true
  end

  class_methods do
    EXPERIENCE_TYPE = 'experience_gain'.freeze
    CHANGED_ATTRIBUTES = 'changed_attributes'.freeze

    EVENT_TYPES = [
      EXPERIENCE_TYPE,
      CHANGED_ATTRIBUTES
    ].freeze
  end
end