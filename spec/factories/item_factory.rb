FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Books::Dune.saying }
    unit_price { Faker::Number.between(from: 1, to:100000) }
    
    merchant factory: :merchant
  end
end