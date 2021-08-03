class ItemsController < ApplicationController
  def index
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, days_until_shipping_id, :price).merge(user_id: current_user.id)
  end

end
