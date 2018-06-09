FactoryBot.define do
  factory :special_class, class: Character::Class do
    name              { Faker::Lorem.word }
    power             { 2 }
    control           { 1 }
    swiftness         { 1 }
    class_type        { Character::Class::SPECIAL }
    skill_id          { 0 }
  end

  factory :prestigious_class, class: Character::Class do
    name              { Faker::Lorem.word }
    power             { 2 }
    control           { 2 }
    swiftness         { 1 }
    class_type        { Character::Class::PRESTIGIOUS }
    skill_id          { 1 }
  end

  factory :legendary_class, class: Character::Class do
    name              { Faker::Lorem.word }
    power             { 2 }
    control           { 2 }
    swiftness         { 2 }
    class_type        { Character::Class::LEGENDARY }
    skill_id          { 2 }
  end

end
