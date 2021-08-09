FactoryBot.define do
  factory :item do
    name {"テスト"}
    description {Faker::Lorem.sentence}
    category_id {2}
    condition_id {2}
    shipping_fee_id {2}
    prefecture_id {2}
    days_until_shipping_id {2}
    price {555}
    
    association :user
  end
end
