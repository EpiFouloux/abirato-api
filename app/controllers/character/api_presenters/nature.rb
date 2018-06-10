# frozen_string_literal: true
module Character::ApiPresenter
  class Nature
    class << self
      def format(nature)
        return {} if nature.nil?
        res = {
          id:   nature.id,
          name: nature.name
        }
        res[:traits] = nature.traits
        res[:modifiers] = nature.modifiers
        res
      end
    end
  end
end