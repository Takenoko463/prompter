class Category < ApplicationRecord
  has_ancestry
  def roots
    Category.all.order('id ASC').limit(9)
  end
end
