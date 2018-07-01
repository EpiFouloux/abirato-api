# frozen_string_literal: true
module Character::ApiPresenter
  class Event
    class << self
      def format(event)
        return {} if event.nil?
        {
          character_instance_id: event.character_instance_id,
          event_type: event.event_type,
          event_data: event.event_data,
          event_date: event.event_date
        }
      end
    end
  end
end