class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  def roots
    find(0).children
  end

  def root_category
    roots[0]
  end

  def categories_index
    category_index = [self]
    category_index.unshift(parent) if has_parent?
    category_index + children if has_children?
  end

  def self.current_category(current_category_id = nil)
    current_category_id ||= 0
    Category.find(current_category_id)
  end
end
