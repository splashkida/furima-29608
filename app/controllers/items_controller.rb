class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :sold_out]
  before_action :sold_out, only: [:edit, :destroy]

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
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :preparation_days_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sold_out
    if @item.purchase_record.present?
      redirect_to root_path
    end
  end
end
