# frozen_string_literal: true
module Character::ApiPresenter
  class Template
    class << self
      def format(template)
        return {} if template.nil?
        res = {
          name:     template.name,
          icon:     template.icon_id,
          picture:  template.picture_id
        }
        res[:skills] = template.skills
        res
      end
    end
  end
end