class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :ai
  with_options presence: true do
    validates :title, length: { maximum: 31 }
    validates :content, length: { minimum: 5, maximum: 3000 }
    validates :nick_name, length: { maximum: 31 }
    validates :ai_id, numericality: { other_than: 0 }
  end
  belongs_to :ai
end
