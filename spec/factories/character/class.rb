FactoryBot.define do
  factory :character_class, class: Character::Class do
    name              { Faker::Lorem.word }
    power             { 2 }
    control           { 1 }
    swiftness         { 1 }
    class_type        { Character::Class::SPECIAL }
    skill_id          { 0 }
  end
end
