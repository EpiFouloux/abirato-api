# frozen_string_literal: true

module ApiPresenter
  class User
    class << self
      def format(user)
        return {} if user.nil?
        res = {
          id:                 user.id,
          name:               user.name,
          level:              user.level,
          experience_amount:  user.experience_amount
        }
        res
      end
    end
  end
end
