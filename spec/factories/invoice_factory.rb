FactoryBot.define do
  factory :invoice do
    status { ['in progess', 'completed', 'cancelled'].sample }

    customer factory: :customer
  end
end