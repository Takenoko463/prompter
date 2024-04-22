class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  def roots
    find(0).children
  end
end
