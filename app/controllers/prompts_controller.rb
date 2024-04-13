class PromptsController < ApplicationController
  before_action :retribute_active_hash, only: [:index, :new]
  def index
    @prompts = Prompt.all
  end

  def new
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.create(prompt_params)
    redirect_to root_path
  end

  private

  def retribute_active_hash
    @ais = Ai.all
  end

  def prompt_params
    params.require(:prompt).permit(:title, :content, :nick_name, :ai_id)
  end
end
