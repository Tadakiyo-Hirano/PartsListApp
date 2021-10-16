FactoryBot.define do
  factory :user do
    name { "test user" }
    sequence(:email) { |n| "test#{n}@email.com" }
    account_level { 1 }
    password { "password" }
    password_confirmation { "password"}
  end
end
