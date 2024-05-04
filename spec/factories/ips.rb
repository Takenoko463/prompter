FactoryBot.define do
  factory :ip do
    ip_md5_head8 { Digest::MD5.hexdigest(Faker::Internet.ip_v4_address)[0, 8] }
  end
end
