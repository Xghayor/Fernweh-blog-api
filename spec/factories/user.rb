FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "John Doe #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
