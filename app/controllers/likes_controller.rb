class LikesController < ApplicationController
  include LikesHelper
  before_action :set_prompt
  def create
    like = Like.new(like_params)
    like.valid?
    like.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    like = Like.find_by(like_params)
    like.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_prompt
    @prompt = Prompt.find(params[:prompt_id])
  end

  def like_params
    { prompt_id: params[:prompt_id], ip_id: session[:ip_id] }
  end
end
