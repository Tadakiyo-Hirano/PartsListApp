FactoryBot.define do
  factory :brand do
    # sequence(:name) { |n| "spec brand_#{n}" }
    name { "spec brand" }
  end
end
