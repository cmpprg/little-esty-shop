FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 20000) }
    status { ['pending', 'packaged', 'shipped'].sample }

    invoice factory: :invoice
    item factory: :item
  end
end