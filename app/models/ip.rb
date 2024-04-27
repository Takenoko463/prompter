class Ip < ApplicationRecord
  validates :ip_md5_head8, length: { maximum: 8 }

  has_many :prompts
  has_many :likes
end
