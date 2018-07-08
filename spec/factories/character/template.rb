FactoryBot.define do
  factory :character_template, class: Character::Template do
    name              { Faker::Lorem.word }
    nature            { Character::Nature.all.sample }
    skill_one_id      { Faker::Number.number(3) }
    skill_two_id      { Faker::Number.number(4) }
    skill_three_id    { Faker::Number.number(5) }
  end
end
