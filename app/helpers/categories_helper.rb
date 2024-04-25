module CategoriesHelper
  def root_category
    Category.roots[0]
  end

  def main_categories
    [root_category] + root_category.children
  end
end
