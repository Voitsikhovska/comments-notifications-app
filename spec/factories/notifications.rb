FactoryBot.define do
  factory :notification do
    association :user
    association :actor, factory: :user
    association :comment
    read { false }
  end
end
