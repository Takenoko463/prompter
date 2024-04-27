FactoryBot.define do
  factory :prompt do
    title { Faker::Alphanumeric.alphanumeric(number: 10) }
    nick_name { Faker::Alphanumeric.alphanumeric(number: 10) }
    content { Faker::Alphanumeric.alphanumeric(number: 10) }
    ai_id { Faker::Number.between(from: 1, to: 2) }
    association :ip
    association :category
  end
end
