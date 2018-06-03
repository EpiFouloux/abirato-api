module Character::Template::ValidationConcern
  extend ActiveSupport::Concern

  included do

    belongs_to :character_nature, class_name: "Nature"
    
    validates :name, presence: true
    validates_uniqueness_of :name
    validates_uniqueness_of :icon_id
    validates_uniqueness_of :picture_id
    validates_uniqueness_of :skill_one_id
    validates_uniqueness_of :skill_two_id
    validates_uniqueness_of :skill_three_id
  end
end