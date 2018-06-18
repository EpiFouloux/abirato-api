module Character::Template::RelationsConcern
  extend ActiveSupport::Concern

  included do
    belongs_to :nature, class_name: 'Nature', foreign_key: 'character_nature_id'
  end
end