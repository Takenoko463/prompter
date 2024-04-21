class PromptsController < ApplicationController
  before_action :retribute_active_hash, only: [:index, :new, :create, :edit, :update, :show]
  before_action :set_prompt, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_ip!, only: [:edit, :update, :destroy]
  def index
    @prompts = Prompt.all.order(id: 'DESC')
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
    params.require(:prompt).permit(:title, :content, :nick_name, :ai_id, :answer).merge(ip_md5_head8: set_ip)
  end

  def set_prompt
    @prompt = Prompt.find(params[:id])
  end

  def ip_to_md5_head8(ip)
    Digest::MD5.hexdigest(ip)[0, 8]
  end

  def set_ip
    ip_plain = request.remote_ip
    ip_to_md5_head8(ip_plain)
  end

  def your_prompt?
    set_ip == @prompt.ip_md5_head8
  end

  def authenticate_ip!
    return if your_prompt?

    redirect_to root_path
  end
end
