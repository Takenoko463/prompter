class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  def roots
    Category.all.order('id DESC').limit(9)
  end
end
