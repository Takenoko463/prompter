class Prompt < ApplicationRecord
  with_options presence: true do
    validates :title, comparison: { less_than: 31 }
    validates :content, comparison: { greater_than: 5, less_than: 3000 }
    validates :nick_name, comparison: { less_than: 31 }
    validates :ai_id, numericality: { other_than: 0 }
  end
end
