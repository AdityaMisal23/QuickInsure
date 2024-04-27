FactoryBot.define do
  factory :movie do
    name {Faker::Name.name}
    genre {%w[action horror drama comedy thriller].sample}
    release_date {Faker::Date.backward(days: 30)}
    # movie_duration(Faker:Number)
  end
end
