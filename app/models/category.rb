class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  def roots
    all.limit(9)
  end
end
