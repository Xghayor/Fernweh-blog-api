
FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    content { "Lorem ipsum dolor sit amet" }
    sequence(:image) { |n| "https://example.com/image#{n}.jpg" }
    association :user
  end
end
