FactoryBot.define do
  factory :order do
    postcode            { '333-3333' }
    prefecture_id       { 28 }
    city                { '大阪市' }
    block_number        { '北区' }
    tel                 { 12_341_234_444 }
    user_id             { 1 }
    item_id             { 1 }
    token               { 'tok_abcdefghijk00000000000000000' }
  end
end
