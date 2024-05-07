class Like < ApplicationRecord
  validates :prompt, uniqueness: { scope: :ip }
  belongs_to :ip
  belongs_to :prompt
  def self.ransackable_associations(_auth_object = nil)
    %w[ip]
  end
end
