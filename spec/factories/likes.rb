FactoryBot.define do
  factory :like do
    ip_md5_head8 { Faker::Alphanumeric.alphanumeric(number: 8) }
    association :prompt
  end
end
