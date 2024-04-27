FactoryBot.define do
  factory :show do
    association :screen
    association :movie
    booked_tickets { 0 }
    show_time { Faker::Time.between(from: DateTime.now, to: (DateTime.now + 30.days)) }
    gold { rand(300..400) }
    platinum { rand(400..500) }
    silver { rand(200..300) }
  end
end
