FactoryBot.define do
  factory :product do
    # model { "spec product" }
    sequence(:model) { |n| "spec product_#{n}" }
    association :category
    association :brand
  end
end
