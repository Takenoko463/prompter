FactoryBot.define do
  factory :category_parent do
    name { 'all' }
  end
  factory :category do
    name { 'current_category' }
    ancestry { '0' }
  end
  factory :category_child do
    name { 'child' }
    ancestry { '0/1' }
  end
end
