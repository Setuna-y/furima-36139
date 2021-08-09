FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    last_name { 'テスト' }
    first_name { 'テスト' }
    last_name_kana { 'テスト' }
    first_name_kana { 'テスト' }
    date_of_birth { Faker::Date.birthday }
  end
end
