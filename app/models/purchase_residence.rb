class PurchaseResidence
  include ActiveModel::Model

  attr_accessor :item_id, :user_id, :zip_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A\d{10,11}\z/}
    validates :token
  end


  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Residence.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end

