module Character::Event::RelationsConcern
  extend ActiveSupport::Concern

  included do
    def character_instance
      Character::Instance.find(character_instance_id)
    end
  end
end