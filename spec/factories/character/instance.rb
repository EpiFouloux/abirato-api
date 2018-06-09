# frozen_string_literal: true

FactoryBot.define do
  factory :character_instance, class: Character::Instance do
    user              { create(:user) }
    template          { create(:character_template) }
    nature            { template.nature }
    name              { Faker::Lorem.characters(5) }
    level             { 1 }
    additive_power    { 1 }
    special_class     do
      if Character::Class.find_by_traits(
        power: nature.power + additive_power,
        control: nature.control + additive_control,
        swiftness: nature.swiftness + additive_swiftness
      ).nil?
        create(:special_class, power: nature.power + additive_power, control: nature.control + additive_control, swiftness: nature.swiftness + additive_swiftness)
      else
        Character::Class.find_by_traits(
          power: nature.power + additive_power,
          control: nature.control + additive_control,
          swiftness: nature.swiftness + additive_swiftness
        )
      end
    end
  end
end
