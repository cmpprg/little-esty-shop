FactoryBot.define do
  factory :invoice do
    status { ['in_progess', 'completed', 'cancelled'].sample }

    customer factory: :customer
  end
end