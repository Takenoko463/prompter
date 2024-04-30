FactoryBot.define do
  factory :ip do
    ip_md5_head8 { Digest::MD5.hexdigest('127.0.0.1')[0, 8] }
  end
end
