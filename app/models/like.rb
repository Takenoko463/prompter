class Like < ApplicationRecord
  validates :ip_md5_head8, presence: true, uniqueness: true
end