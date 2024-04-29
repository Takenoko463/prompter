class PromptsController < ApplicationController
  include PromptsHelper
  before_action :retribute_active_hash, only: [:index, :new, :create, :edit, :update, :show]
  before_action :set_prompt, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_ip!, only: [:edit, :update, :destroy]
  before_action :set_current_category_at_session, only: :index
  before_action :set_current_category, only: [:index, :new, :edit]
  before_action :set_current_categories, only: [:index, :new, :edit]
  def index
    ## categoryと、その子孫に繋がる全てのpromptを取り出す
    @prompts = Prompt.where(category_id: @current_category.subtree.pluck(:id)).order(id: 'DESC')
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
end
