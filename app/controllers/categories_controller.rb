class CategoriesController < ApplicationController
  def children
    @category = Category.find(params[:id])
    @children = @category.children
    respond_to do |format|
      format.json { render json: @children }
    end
  end
end
