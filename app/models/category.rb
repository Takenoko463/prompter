class Category < ApplicationRecord
  has_ancestry
  def roots
    Category.all.order('id DESC').limit(9)
  end
end
