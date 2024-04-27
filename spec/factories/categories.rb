FactoryBot.define do
  factory :category_root do
    name { 'all' }
  end
  factory :category_child do
    name { 'child' }
    ancestry { 0 }
  end
end
