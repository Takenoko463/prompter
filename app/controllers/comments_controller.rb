class CommentsController < ApplicationController
  include CommentsHelper
  before_action :authenticate_ip!
  before_action :set_prompt, only: [:index, :new, :create, :update]
  before_action :set_comment, only: [:edit, :destroy, :update, :show]
  before_action :set_comment_prompt, only: [:edit, :destroy, :show, :destroy]
  before_action :others_comment!, only: [:edit, :update, :show, :destroy]
  def index
    @comments = @prompt.comments.includes(:ip).order(id: 'DESC')
  end

  def new
    @comment = Comment.new(prompt_id: @prompt.id)
    respond_to(&:js)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      cookies[:last_nick_name] = comment_params[:nick_name]
      respond_to(&:js)
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to(&:js)
  end

  def update
    if @comment.update(comment_params)
      cookies[:last_nick_name] = comment_params[:nick_name]
      respond_to(&:js)
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def show
    respond_to(&:js)
  end

  def destroy
    @comment.destroy
    redirect_to action: :index, prompt_id: @prompt.id
  end

  private

  def set_prompt
    @prompt = Prompt.find(params[:prompt_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :nick_name, :prompt_id).merge(ip_id: session[:ip_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comment_prompt
    @prompt = @comment.prompt
  end

  def your_comment?
    @comment.ip == current_ip
  end

  def others_comment!
    return if your_comment?

    redirect_to root_path
  end
end
