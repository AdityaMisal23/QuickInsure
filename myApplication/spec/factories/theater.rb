FactoryBot.define do
  factory :theater do
    association :user
    theater_name { Faker::Company.name }
    theater_address { Faker::Address.full_address }
    pincode { Faker::Number.number(digits: 6) }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
    association :location
    is_active { true }
  end
end
