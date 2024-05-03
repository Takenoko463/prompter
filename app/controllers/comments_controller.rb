class CommentsController < ApplicationController
  before_action :set_prompt, only: [:index, :new, :create, :update]
  before_action :set_comment, only: [:edit, :destroy, :update, :show]
  before_action :set_comment_prompt, only: [:edit, :destroy, :show]
  def index
    @comments = @prompt.comments.order(id: 'DESC')
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
end
