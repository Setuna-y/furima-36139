# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| date_of_birth      | date   | null: false |

has_many :items
has_many :purchases

## items テーブル

| Column                 | Type    | Options     |
| name                   | string  | null: false |
| description            | text    | null: false |
| category_id            | integer | null: false |
| condition_id           | integer | null: false |
| shipping_fee_id        | integer | null: false |
| prefecture_id          | integer | null: false |
| days_until_shipping_id | integer | null: false |
| price                  | integer | null: false |
| user                | references | null: false, foreign_key: true |

belongs_to :user
has_one :purchase

## purchases テーブル

| Column | Type       | Options     |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

belongs_to :user
belongs_to :item
has_one : residence

## residences テーブル

| Column        | Type       | Options     |
| zip_code_id   | integer    | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| address       | string     | null: false |
| building_name | string     |             |
| phone_number  | string     | null: false |
| purchase      | references | null: false, foreign_key: true |

belongs_to :purchase