class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show edit]

  def index
    @items = Item.all.order(created_at: 'DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to root_path if @item.user != current_user
  end

  def update
    @item = Item.find(params[:id])
    item.update(item_params)
  end

  # def destroy
  # @item = Item.find(params[:id])
  # item.destroy
  # end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :days_until_shipping_id, :price).merge(user_id: current_user.id)
  end
end
