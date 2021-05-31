FactoryBot.define do
  factory :product do
    sequence(:model) { |n| "spec product_#{n}" }
  end
end
