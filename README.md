# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| nickname           | strings | null: false |
| email              | strings | null: false |
| encrypted_password | strings | null: false |
| last_name          | strings | null: false |
| first_name         | strings | null: false |
| last_name_kana     | strings | null: false |
| first_name_kana    | strings | null: false |
| date_of_birth      | date    | null: false |

has_many :items
has_many :purchases

## items テーブル

| Column           | Type       | Options     |
| image            |            | null: false |
| name             | strings    | null: false |
| description      | text       | null: false |
| category         | strings    | null: false |
| condition        | strings    | null: false |
| shipping_fee     | strings    | null: false |
| shipping_from    | strings    | null: false |
| preparation_days | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true |

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
| zip_code      | integer    | null: false |
| prefectures   | strings    | null: false |
| city          | strings    | null: false |
| address       | strings    | null: false |
| building_name | strings    | null: false |
| phone_number  | integer    | null: false |
| item          | references | null: false, foreign_key: true |

belongs_to :purchase