class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :retribute_active_hash, only: [:show]
  before_action :set_categories, only: [:show]
  def children
    @category = Category.find(params[:id])
    @children = @category.children
    respond_to do |format|
      format.json { render json: @children }
    end
  end

  def show
    @prompts = @category.prompts
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def retribute_active_hash
    @ais = Ai.all
  end

  def set_categories
    @categories = Category.roots.order(id: 'DESC')
  end
end
