FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "spec brand_#{n}" }
  end
end
