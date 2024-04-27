FactoryBot.define do
  factory :screen do
    name { Faker::Name.name }
    association :theater
    number_of_seats { 100 }
  end
end
