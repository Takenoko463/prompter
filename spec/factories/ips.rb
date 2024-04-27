FactoryBot.define do
  factory :ip do
    ip_md5_head8 { Faker::Alphanumeric.alphanumeric(number: 8) }
  end
end
