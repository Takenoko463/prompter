module CategoriesHelper
  def set_current_category_at_session
    params_category_id = params[:category_id] || params[:q].try(:[], :subtree_category) || 0
    session[:current_category_id] = params_category_id
  end

  def current_category_id
    session[:current_category_id] || 0
  end

  def current_category
    @current_category ||= Category.current_category(current_category_id)
  end

  def current_categories
    @current_categories ||= Category.current_categories(current_category_id)
  end
end
