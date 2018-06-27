class Character::Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination

  after_create :apply_event_data

  field :character_instance_id, type: Integer
  field :event_type, type: String
  field :event_date, type: DateTime
  field :event_data, type: Hash

  index({ character_instance_id: 1 }, unique: true)

  validates_presence_of :character_instance_id
  validates_presence_of :event_type
  validates_presence_of :event_date
  validates_presence_of :event_data

  def character_instance
    Characte::Instance.find(character_instance_id)
  end

  class << self

    EXPERIENCE_TYPE = 'experience_gain'.freeze

    EVENT_TYPES = [
      EXPERIENCE_TYPE
    ].freeze
  end

  private

  def apply_event_data
    case event_type
    when EXPERIENCE_TYPE
      character_instance.experience_amount += event_data[:amount]
      character_instance.save!
    end
  end
end
