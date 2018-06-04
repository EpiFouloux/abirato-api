FactoryBot.define do
  factory :character_template, class: Character::Template do
    name              { Faker::Lorem.word }
    character_nature  { create(:character_nature) }
    picture_id        { 0 }
    icon_id           { Faker::Number.number(1) }
    skill_one_id      { Faker::Number.number(2) }
    skill_two_id      { Faker::Number.number(3) }
    skill_three_id    { Faker::Number.number(4) }
  end
end
