require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入機能'
  context '商品購入がうまくいく時' do
    it 'token・ユーザー情報・アイテム情報・郵便番号・都道府県・市区町村・番地・電話番号があれば購入できる' do
      expect(@order).to be_valid
    end
  end

  context '商品購入がうまくいかない時' do
    it '郵便番号がないと購入できない' do
      @order.postcode = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Postcode can't be blank")
    end

    it '都道府県がないと購入できない' do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '市区町村がないと購入できない' do
      @order.city = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end

    it '番地がないと購入できない' do
      @order.city = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end

    it '電話番号がないと購入できない' do
      @order.tel = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Tel can't be blank")
    end

    it '郵便番号にはハイフンがないと購入できない' do
      @order.postcode = 12_345_678
      @order.valid?
      expect(@order.errors.full_messages).to include('Postcode is invalid')
    end

    it '電話番号にはハイフンが不要である' do
      @order.tel = 123 - 456 - 890
      @order.valid?
      expect(@order.errors.full_messages).to include('Tel is invalid')
    end

    it '電話番号は１１桁以内の数字である' do
      @order.tel = 12_345_678_912_345
      @order.valid?
      expect(@order.errors.full_messages).to include('Tel is invalid')
    end

    it 'userが紐づいていないと購入できない' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが紐づいていないと購入できない' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが空では登録できないこと' do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
