FactoryBot.define do
  factory :help do
    name {"name"}
    description {"description"}
    point {10}
    association :parent, factory: :parent
    association :child, factory: :child
  end
end
