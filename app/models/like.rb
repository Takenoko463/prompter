class Like < ApplicationRecord
  validates :prompt, uniqueness: { scope: :ip }
  belongs_to :ip
  belongs_to :prompt
end
