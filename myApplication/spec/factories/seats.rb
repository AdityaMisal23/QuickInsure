FactoryBot.define do
  factory :seat do
    row { "A" }
    column { 1 }
    section { "Platinum" }

    factory :seat_with_show do
      association :resource, factory: :show
      resource_type { "Show" }
    end

    factory :seat_with_screen do
      association :resource, factory: :screen
      resource_type { "Screen" }
    end
  end
end
