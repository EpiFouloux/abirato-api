FactoryBot.define do
  factory :character_instance, class: Character::Instance do
    name              { Faker::Lorem.word }
    level             { 1 }
  end
end
