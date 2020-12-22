require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能'
  context '商品出品がうまく行く時' do
    it 'ユーザー・画像・商品名・説明・カテゴリー・商品の状態・発送元の地域・発送までの日数・価格があれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '新規登録がうまくいかない時' do
    it '画像がないと出品できない' do
      @item.image = nil
      @item.valid?
      # binding.pry
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品名がないと出品できない' do
      @item.item_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end
    it '商品の説明がないと出品できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'カテゴリーの情報がなければ保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end
    it '商品の状態についての情報がなければ保存できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 1')
    end
    it '配送料の負担についての情報がなければ保存できない' do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee must be other than 1')
    end
    it '発送元の地域についての情報がなければ保存できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end
    it '発送までの日数についての情報がなければ保存できない' do
      @item.preparation_days_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Preparation days must be other than 1')
    end
    it '価格についての情報がなければ保存できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'userが紐付いていないと保存できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
    it '価格が、¥300より低いと保存できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end
    it '価格が、¥9,999,999より高いと保存できない' do
      @item.price = 999_999_999
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end
    it '販売価格は半角数字でないと保存できない' do
      @item.price = '６６６'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
