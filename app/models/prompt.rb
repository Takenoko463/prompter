class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # include IpModule

  belongs_to_active_hash :ai
  with_options presence: true do
    validates :title, length: { maximum: 31 }
    validates :content, length: { minimum: 5, maximum: 3000 }
    validates :nick_name, length: { maximum: 31 }
    validates :ai_id, numericality: { other_than: 0 }
    validates :ip_md5_head8
  end
  belongs_to :ai

  def first_line
    content.split("\n").first
  end

  def remaining_content
    content.split("\n")[1..].join("\n")
  end
end
