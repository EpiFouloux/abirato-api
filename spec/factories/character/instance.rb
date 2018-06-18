# frozen_string_literal: true

FactoryBot.define do
  factory :character_instance, class: Character::Instance do
    user              { create(:user) }
    template          { Character::Template.all.sample }
    nature            { template.nature }
    waiting_trait     { false }
    name              { Faker::Lorem.characters(5) }
    level             { 1 }
    additive_power    { 1 }
    special_class     do
      Character::Class.find_by_traits(
        power: nature.power + additive_power,
        control: nature.control + additive_control,
        swiftness: nature.swiftness + additive_swiftness
      )
    end
  end
end
