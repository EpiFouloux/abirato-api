# frozen_string_literal: true

module Character::ApiPresenter
  class Class
    class << self
      def format(character_class)
        return {} if character_class.nil?
        res = {
          id:           character_class.id,
          name:         character_class.name,
          class_type:   character_class.class_type,
          skill:        character_class.skill_id
        }
        res[:traits] = character_class.traits
        res
      end
    end
  end
end
