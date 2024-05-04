FactoryBot.define do
  factory :comment do
    nick_name { Faker::Alphanumeric.alphanumeric(number: 10) }
    content { Faker::Alphanumeric.alphanumeric(number: 10) }
    association :ip
    association :prompt
  end
end
