FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "Abc@1231223" }
    role { "admin" }
  end
end
