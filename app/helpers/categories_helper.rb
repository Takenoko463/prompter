module CategoriesHelper
  def set_current_category_at_session
    selected_category_id = params[:category_id].present? ? params[:category_id] : 0
    session[:current_category_id] = selected_category_id
  end

  def current_category_id
    session[:current_category_id]
  end

  def set_current_category
    @current_category = Category.current_category(current_category_id)
  end

  def set_current_categories
    @current_categories = Category.current_categories(current_category_id)
  end

  def main_categories
    @main_categories ||= Category.current_categories
  end
end
