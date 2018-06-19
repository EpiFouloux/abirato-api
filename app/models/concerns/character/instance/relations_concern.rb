module Character::Instance::RelationsConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :template, class_name: "Template", foreign_key: 'character_template_id'
    belongs_to :nature, class_name: "Nature", foreign_key: 'character_nature_id'
    belongs_to :special_class, class_name: "Class", foreign_key: 'character_special_class_id'
    belongs_to :prestigious_class, class_name: "Class", foreign_key: 'character_prestigious_class_id', required: false
    belongs_to :legendary_class, class_name: "Class", foreign_key: 'character_legendary_class_id', required: false

    has_many :events, class_name: "Event", foreign_key: "character_instance_id", dependent: :destroy
  end
end