require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  describe 'GET /prompts' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get prompts_path
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
    end
  end
end
