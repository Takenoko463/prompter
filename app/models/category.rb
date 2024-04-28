class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  def roots
    find(0).children
  end

  def self.root_category
    roots[0]
  end

  def self.current_categories(current_category_id = nil)
    current_category_id ||= 0
    target_category = current_category(current_category_id)
    if target_category.has_siblings? && !target_category.is_root?
      [target_category.parent] + target_category.sibling
    else
      [root_category] + root_category.children
    end
  end

  def self.current_category(current_category_id = nil)
    current_category_id ||= 0
    Category.find(current_category_id)
  end
end
