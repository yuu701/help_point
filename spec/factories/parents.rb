FactoryBot.define do
  factory :parent do
    name {"name"}
    sequence(:email) { |n| "name#{n}@example.com"}
    password {"password1"}
  end
end
