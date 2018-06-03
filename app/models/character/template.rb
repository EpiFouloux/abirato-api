class Character::Template < ApplicationRecord
  include Character::Template::ValidationConcern

  def skill_ids
    [
      skill_one_id,
      skill_two_id,
      skill_three_id
    ]
  end
end
