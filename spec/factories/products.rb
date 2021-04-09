FactoryBot.define do
  factory :product do
    FactoryBot.build(:category)
    FactoryBot.build(:brand)

    model { "spec sample product" }
    category_id { 1 }
    brand_id { 1 }
  end
end
