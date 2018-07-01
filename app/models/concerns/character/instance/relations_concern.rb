module Character::Instance::RelationsConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :template, class_name: "Template", foreign_key: 'character_template_id'
    belongs_to :nature, class_name: "Nature", foreign_key: 'character_nature_id'
    belongs_to :special_class, class_name: "Class", foreign_key: 'character_special_class_id'
    belongs_to :prestigious_class, class_name: "Class", foreign_key: 'character_prestigious_class_id', required: false
    belongs_to :legendary_class, class_name: "Class", foreign_key: 'character_legendary_class_id', required: false

    def events
      Character::Event.where(character_instance_id: id).entries
    end

    def current_class
      classes.last
    end

    def classes
      [
        special_class,
        prestigious_class,
        legendary_class
      ].compact
    end

    def class_keys
      %i[
        character_special_class_id
        character_prestigious_class_id
        character_legendary_class_id
      ]
    end
  end
end