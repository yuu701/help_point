FactoryBot.define do
  factory :apply do
    comment {"comment"}
    completion_date {"2021-01-05"}
    close {false}
    association :request, factory: :request
  end
end
