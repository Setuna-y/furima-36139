class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :purchase

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, presence: true,
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_until_shipping

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_until_shipping_id
  end
end
