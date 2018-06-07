FactoryBot.define do
  factory :character_instance, class: Character::Instance do
    user              { create(:user) }
    template          { create(:character_template) }
    nature            { template.nature }
    name              { Faker::Lorem.characters(5) }
    level             { 1 }
    additive_power    { 1 }
    special_class     { create(:special_class)}
  end
end
