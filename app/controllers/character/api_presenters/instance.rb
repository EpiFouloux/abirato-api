# frozen_string_literal: true
module Character::ApiPresenter
  class Instance
    class << self
      def format(instance)
        return {} if instance.nil?
        res = {
          id:                       instance.id,
          name:                     instance.name,
          level:                    instance.level,
          experience_amount:        instance.experience_amount,
          target_experience_amount: instance.class.target_experience(instance.level + 1),
          nature:                   instance.character_nature_id,
          template:                 instance.character_template_id,
          waiting_trait:            instance.waiting_trait?,
          waiting_modifier:         instance.waiting_modifier?
        }
        res[:traits] =              instance.traits
        res[:modifiers] =           instance.modifiers
        res[:classes] =   []
        instance.classes.each do |c|
          res[:classes] << {
            name: c.name,
            category: c.class_type
          }
        end
        res
      end
    end
  end
end