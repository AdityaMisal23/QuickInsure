FactoryBot.define do
  factory :log do
    association :user
    name {Faker::Name.name}
    action {Faker::Name.name}
  end
end
