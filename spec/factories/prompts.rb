FactoryBot.define do
  factory :prompt do
    title { Faker::Alphanumeric.alphanumeric(number: 10) }
    nick_name { Faker::Alphanumeric.alphanumeric(number: 10) }
    content { Faker::Alphanumeric.alphanumeric(number: 10) }
    ai_id { Faker::Number.between(from: 1, to: 2) }
    ip_md5_head8 { Faker::Alphanumeric.alphanumeric(number: 8) }
    association :category
  end
end
