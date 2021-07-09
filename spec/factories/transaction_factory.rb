FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.between(from: 10000000000000000, to: 9999999999999999) }
    result { ['failed', 'success'].sample }

    invoice factory: :invoice
  end 
end