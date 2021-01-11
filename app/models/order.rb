class Order
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :prefecture_id, :city, :block_number, :building_name, :tel, :token

  # 「クレカ情報」に関するバリデーション
  validates :token, presence: true

  # 「purchase_record」に関するバリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
  end

  # 「address」に関するバリデーション
  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :block_number
    validates :tel, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block_number: block_number, building_name: building_name, tel: tel, purchase_record_id: purchase_record.id)
  end
end
