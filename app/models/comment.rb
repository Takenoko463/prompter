class Comment < ApplicationRecord
  belongs_to :prompt
  belongs_to :ip

  with_options presence: true do
    validates :nick_name, length: { maximum: 30 }
    validates :content, length: { minimum: 5, maximum: 3000 }
  end
end
