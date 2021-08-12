FactoryBot.define do
  factory :purchase_residence do
    zip_code { '123-4748' }
    prefecture_id { 2 }
    city { "あ" }
    address { '555' }
    phone_number { '1234567891' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
