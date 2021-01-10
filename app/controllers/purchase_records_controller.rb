class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :user_restriction, only: [:index, :create]
  before_action :sold_out, only: [:index, :create]

  def index
    # item情報を探してきて表示させる
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    # orderモデルで定義したsaveと同じsave
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  # 出品者はURLを直接入力して購入ページへ遷移しようとするとトップページへ遷移される
  def user_restriction
    redirect_to root_path if current_user.id == @item.user_id
  end

  # URLを直接入力して購入済み商品の購入ページへ遷移しようとするとトップページへ遷移される
  def sold_out
    if @item.purchase_record.present?
      # 「@item.purchase_record != nil」ともかける
      redirect_to root_path
    end
  end

  # createアクションのPAY.JPの記述をリファクタリング
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :item_id, :postcode, :prefecture_id, :city, :block_number, :building_name, :tel, :purchase_record_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
