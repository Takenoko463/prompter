class Category < ApplicationRecord
  has_ancestry
  has_many :prompts

  def self.root_children
    root_category.children
  end

  def self.root_category
    roots[0]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name ancestry]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[prompts]
  end

  def self.main_categories
    [root_category] + root_children
  end

  def self.current_categories(current_category_id = nil)
    target_category = current_category(current_category_id)
    if target_category.is_root?
      main_categories
    elsif !target_category.has_children?
      [target_category.parent] + target_category.siblings
    else
      [target_category.parent, target_category] + target_category.children
    end
  end

  def self.current_category(current_category_id = nil)
    return root_category if current_category_id.nil? || current_category_id == '0'

    Category.find(current_category_id)
  end
end
