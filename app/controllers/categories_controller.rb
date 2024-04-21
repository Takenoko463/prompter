class CategoriesController < ApplicationController
  def new
    @categories = Category.new
    @main_categories = Category.all.order('id ASC').limit(13)
  end
end
