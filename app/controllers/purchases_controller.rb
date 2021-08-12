class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    if @item.user == current_user || @item.purchase != nil
      redirect_to root_path
    else
      @purchase_residence = PurchaseResidence.new
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_residence = PurchaseResidence.new(purchase_params)
    #binding.pry
    if @purchase_residence.valid?
      pay_item
      @purchase_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
    def purchase_params
      params.require(:purchase_residence).permit(:zip_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
    end

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,  
        card: purchase_params[:token], 
        currency: 'jpy'
      )
    end

end
