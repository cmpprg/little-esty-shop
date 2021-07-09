FactoryBot.define do
  factory :invoice do
    status { Faker::Number.between(from: 0, to: 2) }

    customer factory: :customer
  end
end