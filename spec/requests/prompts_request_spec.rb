require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  describe 'GET /prompts' do
    before do
      FactoryBot.create(:category, id: 0, name: '全て', ancestry: nil)
      FactoryBot.create(:category, id: 1, name: 'カテゴリ1', ancestry: '0')
      FactoryBot.create(:category, id: 2, name: 'カテゴリ2', ancestry: '0/1')
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get prompts_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
    end
  end
end
