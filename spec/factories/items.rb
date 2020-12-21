FactoryBot.define do
  factory :item do
    item_name             { 'テスト' }
    description           { 'テストテストテスて' }
    category_id           { 3 }
    status_id             { 3 }
    shipping_fee_id       { 3 }
    prefecture_id         { 3 }
    preparation_days_id   { 3 }
    price                 { 400 }
    user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
