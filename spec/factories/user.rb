FactoryBot.define do
    factory :user do
      name { 'John Doe' }
      email { 'john@example.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end