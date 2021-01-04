FactoryBot.define do
  factory :request do
    name {"name"}
    description {"description"}
    point {10}
    request_date {"2021-01-05"}
    status {false}
    association :parent, factory: :parent
    association :child, factory: :child
  end
end
