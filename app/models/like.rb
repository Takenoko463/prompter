class Like < ApplicationRecord
  validates :ip_md5_head8, presence: true, uniqueness: { scope: :prompt_id }
  belongs_to :prompt
end
