# frozen_string_literal: true
module Character::ApiPresenter
  class Nature
    class << self
      def format(nature)
        return {} if nature.nil?
        res = {
          name: nature.name
        }
        res[:traits] = nature.traits
        res[:modifiers] = nature.modifiers
        res
      end
    end
  end
end