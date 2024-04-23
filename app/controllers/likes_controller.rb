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

  private

  def set_prompt
    @prompt = Prompt.find(params[:prompt_id])
  end

  def like_params
    { prompt_id: params[:prompt_id], ip_md5_head8: current_ip_md5_head8 }
  end
end
