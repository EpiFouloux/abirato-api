FactoryBot.define do
  factory :character_template, class: Character::Template do
    name              { Faker::Lorem.word }
    character_nature  { create(:character_nature) }
  end
end
