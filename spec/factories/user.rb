FactoryBot.define do
  factory :user, class: User do
    name  { Faker::Lorem.word }
    email { Faker::Internet.email }
  end
end