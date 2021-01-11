class HomeController < ApplicationController
  before_action :move_to_index, except: [:index]

  def index
  end

  def index
    @item = Item.new
    @items = Item.order('created_at DESC')
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
