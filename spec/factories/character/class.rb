FactoryBot.define do
  factory :character_class, class: Character::Class do
    name              { Faker::Lorem.word }
    power             { 1 }
    control           { 1 }
    swiftness         { 1 }
    type              { Character::Class::SPECIAL }
  end
end
