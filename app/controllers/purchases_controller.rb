class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :item, only: [:index, :create]
  before_action :check, only: [:index, :create]


  def index
    @purchase_residence = PurchaseResidence.new
  end

  def create
    @purchase_residence = PurchaseResidence.new(purchase_params)
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

    def item
      @item = Item.find(params[:item_id])
    end

    def check
      if @item.user == current_user || @item.purchase != nil
        redirect_to root_path
      end
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
