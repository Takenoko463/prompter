class PromptsController < ApplicationController
  include PromptsHelper
  before_action :retribute_active_hash, only: [:index, :new, :create, :edit, :update, :show]
  before_action :set_prompt, only: [:edit, :update, :destroy, :show]
  before_action :set_category_index, only: [:index]
  before_action :set_root_category, only: [:new, :create, :edit, :update]
  before_action :set_main_categories, only: [:new, :create, :edit, :update]
  before_action :authenticate_ip!, only: [:edit, :update, :destroy]
  def index
    ## categoryと、その子孫に繋がる全てのpromptを取り出す
    @prompts = Prompt.where(category_id: @category.subtree.pluck(:id))
  end

  def new
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
      cookies[:last_nick_name] = prompt_params[:nick_name]
      redirect_to root_path
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    if @prompt.update(prompt_params)
      redirect_to root_path
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prompt.destroy
    redirect_to root_path
  end

  private

  def retribute_active_hash
    @ais = Ai.all
  end

  def prompt_params
    params.require(:prompt).permit(:title, :content, :nick_name, :ai_id, :answer, :category_id).merge(ip_md5_head8: set_ip)
  end

  def set_prompt
    @prompt = Prompt.find(params[:id])
  end

  def authenticate_ip!
    return if your_prompt?(@prompt)

    redirect_to root_path
  end

  def set_category_index
    set_category
    set_category_parent
    @categories = @category.children
  end

  def set_category
    selected_category_id = params[:category_id].present? ? params[:category_id] : 0

    @category = Category.find(selected_category_id)
  end

  def set_category_parent
    @parent_category = @category.parent if @category.has_parent?
  end

  def set_main_categories
    @categories = [@category] + @category.children
  end

  def set_root_category
    @category = Category.roots[0]
  end
end
