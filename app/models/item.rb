class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :preparation_days
  belongs_to :shipping_fee
  belongs_to :status

  validates :category_id, :prefecture_id, :preparation_days_id, :shipping_fee_id, :status_id, numericality: { other_than: 1 }

  with_options presence: true do
    validates :image
    validates :item_name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price, numericality: { only_integr: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end
