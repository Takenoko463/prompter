class Category < ApplicationRecord
  has_ancestry
  has_many :prompts
  ROOT = roots[0]
  ROOTS = ROOT.children
  def self.roots
    ROOTS
  end

  def self.root_category
    ROOT
  end

  def self.current_categories(current_category_id = nil)
    return [root_category] + roots if current_category_id.nil? || current_category_id == '0'

    target_category = current_category(current_category_id)
    target_category.has_siblings? && !target_category.is_root?
    [target_category.parent] + target_category.siblings
  end

  def self.current_category(current_category_id = nil)
    return root_category if current_category_id.nil? || current_category_id == '0'

    Category.find(current_category_id)
  end
end
