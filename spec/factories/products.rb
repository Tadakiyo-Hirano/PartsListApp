FactoryBot.define do
  factory :product do
    model { "spec product" }
    # sequence(:model) { |n| "spec product_#{n}" }
    category_id { 1 }
    brand_id { 1 }
    # association :category
    # association :brand
  end
end
