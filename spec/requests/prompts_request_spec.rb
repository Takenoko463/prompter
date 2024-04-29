require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  before do
    # ipをデータベースに登録
    @ip = FactoryBot.create(:ip)
    # categoryをrootから孫まで定義
    @category_root = FactoryBot.create(:category, id: 0, name: '全て', ancestry: nil)
    FactoryBot.create(:category, id: 1, name: 'カテゴリ1', ancestry: '0')
    FactoryBot.create(:category, id: 2, name: 'カテゴリ2', ancestry: '0/1')
    @prompt = FactoryBot.create(:prompt, category: @category_root, ip: @ip)
  end
  describe 'GET /prompts' do
    context 'indexアクションに成功する' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get prompts_path
        expect(response).to have_http_status(:success)
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
        get prompts_path
        expect(response.body).to include(@prompt.content)
      end
    end
  end
  describe 'GET /prompts/new' do
    it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
      get new_prompt_path
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /prompts' do
    context 'createアクションに成功する' do
      before 'IP IDをセッションから取り出せるようにする' do
        mock_session = ActionController::TestSession.new(ip_id: @ip.id)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_session)
      end
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        post prompts_path, params: { prompt: prompt_params }
        expect(response).to redirect_to action: 'index'
      end
      it 'createアクションにリクエストすると@ip由来のpromptデータが追加される' do
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        expect { post prompts_path, params: { prompt: prompt_params } }.to change(@ip.prompts, :count).by(1)
      end
    end
  end
end
