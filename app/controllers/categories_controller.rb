class CategoriesController < ApplicationController
  include CategoriesHelper
  def children
    @category = Category.find(params[:id])
    @children = @category.children
    respond_to do |format|
      format.json { render json: @children }
    end
  end

  def index
    respond_to do |format|
      format.json { render json: current_categories }
    end
  end
end
