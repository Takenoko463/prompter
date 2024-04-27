class Ip < ApplicationRecord
  validates :ip_md5_head8, presence: true, length: { is: 8 }, uniqueness: true

  has_many :prompts
  has_many :likes
end
