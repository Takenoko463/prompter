require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  before 'ipをデータベースに登録' do
    @ip = FactoryBot.create(:ip)
  end
  before 'IP IDをセッションから取り出せるようにする' do
    mock_session = ActionController::TestSession.new(ip_id: @ip.id)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_session)
  end
  before 'categoryをrootから孫まで定義' do
    @category_root = FactoryBot.create(:category, id: 0, name: '全て', ancestry: nil)
    FactoryBot.create(:category, id: 1, name: 'カテゴリ1', ancestry: '0')
    FactoryBot.create(:category, id: 2, name: 'カテゴリ2', ancestry: '0/1')
  end
  before 'テストを動かしているipで、promptを作成' do
    @prompt = FactoryBot.create(:prompt, category: @category_root, ip: @ip)
  end
  describe 'Post /prompts/:prompt_id/likes' do
    context 'createアクションに成功する' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        post prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response).to have_http_status(:success)
      end
      it 'createアクションにリクエストするとlikeが保存される' do
        expect { post prompt_likes_path(@prompt), xhr: true, as: :js }.to change(@ip.likes, :count).by(1)
      end
      it 'createアクションにリクエストすると消去ボタン作成javascriptがレスポンスとして返ってくる' do
        post prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.body).to include 'delete'
      end
    end
    context 'createアクションに失敗する' do
      it 'ipを特定できていないと他ページへリダイレクトする' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        post prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.status).to eq 302
      end
      it '同じipから2回作成を行うと他ページへリダイレクトする' do
        FactoryBot.create(:like, ip: @ip, prompt: @prompt)
        post prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.status).to eq 302
      end
    end
  end
  describe 'Delete /prompts/:prompt_id/likes' do
    before 'likeを登録済み' do
      @like = FactoryBot.create(:like, prompt: @prompt, ip: @ip)
    end
    context 'destroyアクションに成功する' do
      it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
        delete prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response).to have_http_status(:success)
      end
      it 'destroyアクションにリクエストするとlikesデータが削除される' do
        expect { delete prompt_likes_path(@prompt), xhr: true, as: :js }.to change(@ip.likes, :count).by(-1)
      end
      it 'createアクションにリクエストするとlike作成ボタンを作成するjavascriptがレスポンスとして返ってくる' do
        delete prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.body).to include 'post'
      end
    end
    context 'destroyアクションに失敗する' do
      it 'ipを特定できていないと他ページへリダイレクトする' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        delete prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.status).to eq 302
      end
      it '消去を2回行うと他ページへリダイレクトする' do
        @like.destroy
        delete prompt_likes_path(@prompt), xhr: true, as: :js
        expect(response.status).to eq 302
      end
    end
  end
end
