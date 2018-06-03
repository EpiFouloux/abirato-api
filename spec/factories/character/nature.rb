FactoryBot.define do
  factory :character_nature, class: Character::Nature do
    name          { Faker::Lorem.word }
    power         { 1 }
    control       { 1 }
    swiftness     { 1 }
    strength      { 2 }
    dexterity     { 1 }
    constitution  { 1 }
    intelligence  { 1 }
  end
end
