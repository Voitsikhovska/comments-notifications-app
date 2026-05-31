FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 5..15, separators: ["_"]) }
    email    { Faker::Internet.unique.email }
    password { "Password1!" }
    password_confirmation { "Password1!" }
  end
end

