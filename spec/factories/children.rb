FactoryBot.define do
  factory :child do
    name {"name"}
    sequence(:login_id) { |n| "#{n}aaa"}
    password {"password1"}
    association :icon, factory: :icon
    association :parent, factory: :parent
  end
end
