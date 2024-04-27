FactoryBot.define do
  factory :booking do
    association :user
    association :show
    seats {[]}
  end
end
