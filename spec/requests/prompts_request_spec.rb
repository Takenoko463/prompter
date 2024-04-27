require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  describe 'GET /prompts' do
    before do
      # ipをデータベースに登録
      @ip = FactoryBot.create(:ip)
      # categoryをrootから孫まで定義
      @category_root = FactoryBot.create(:category, id: 0, name: '全て', ancestry: nil)
      FactoryBot.create(:category, id: 1, name: 'カテゴリ1', ancestry: '0')
      FactoryBot.create(:category, id: 2, name: 'カテゴリ2', ancestry: '0/1')
      @prompt = FactoryBot.create(:prompt, category: @category_root, ip: @ip)
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get prompts_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
      get prompts_path
      expect(response.body).to include(@prompt.content)
    end
  end
end
