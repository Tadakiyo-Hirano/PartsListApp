FactoryBot.define do
  factory :admin do
    email { "test_admin@email.com" }
    password { "password" }
    password_confirmation { "password"}
  end
end
