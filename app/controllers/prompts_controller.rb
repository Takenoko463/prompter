class PromptsController < ApplicationController
  before_action :retribute_active_hash, only: [:index, :new]
  def index
    @prompts = Prompt.all
  end

  def new
    @prompt = Prompt.new
  end

  private

  def retribute_active_hash
    @ais = Ai.all
  end
end
