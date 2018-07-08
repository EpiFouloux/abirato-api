# frozen_string_literal: true
module Character::ApiPresenter
  class Template
    class << self
      def format(template)
        return {} if template.nil?
        res = {
          id:       template.id,
          name:     template.name,
          nature:   template.character_nature_id
        }
        res[:skills] = template.skills
        res
      end
    end
  end
end