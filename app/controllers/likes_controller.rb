class LikesController < ApplicationController
  include LikesHelper
  before_action :set_prompt
  def create
    like = current_ip.likes.new(prompt: @prompt)
    like.valid?
    if like.save
      respond_to(&:js)
    else
      redirect_to prompts_path, flash: { error: like.errors.full_messages }
    end
  end

  def destroy
    like = Like.find_by(prompt_id: @prompt.id, ip_id: current_ip.id)
    like.destroy
    respond_to(&:js)
  end

  private

  def set_prompt
    @prompt = Prompt.find(params[:prompt_id])
  end
end
