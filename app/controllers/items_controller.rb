class ItemsController < ApplicationController


  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    # @items.images.new
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


  private

  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :preparation_days_id, :price).merge(user_id: current_user.id)
  end

end