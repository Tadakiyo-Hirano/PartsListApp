FactoryBot.define do
  factory :category do
    # sequence(:name) { |n| "spec category_#{n}" }
    name { "spec category" }
  end
end
