class Character::Template < ApplicationRecord
  include Character::Template::ValidationConcern

  def skill_ids
    [
      skill_one_id,
      skill_two_id,
      skill_three_id
    ]
  end

  def skills
    {
        skill_one:    skill_one_id,
        skill_two:    skill_two_id,
        skill_three:  skill_three_id,
    }
  end
end

