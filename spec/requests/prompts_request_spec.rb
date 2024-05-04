require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
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
    context 'indexアクションに失敗する' do
      it 'ipを登録していない' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        get prompts_path
        expect(response.status).to eq 302
      end
    end
  end
  describe 'GET /prompts/new' do
    context 'newアクションに成功する' do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
        get new_prompt_path, xhr: true, as: :html
        expect(response).to have_http_status(:success)
      end
    end
    context 'newアクションに失敗する' do
      it 'ipを登録していない' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        get new_prompt_path, xhr: true, as: :html
        expect(response.status).to eq 302
      end
    end
  end
  describe 'POST /prompts' do
    context 'createアクションに成功する' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        post prompts_path, params: { prompt: prompt_params }, xhr: true, as: :js
        expect(response).to have_http_status(:success)
      end
      it 'createアクションにリクエストすると@ip由来のpromptデータが追加される' do
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        expect { post prompts_path, params: { prompt: prompt_params }, xhr: true, as: :js }.to change(@ip.prompts, :count).by(1)
      end
      it 'answerが空でもpromptデータが追加される' do
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        prompt_params[:answer] = ''
        expect { post prompts_path, params: { prompt: prompt_params }, xhr: true, as: :js }.to change(@ip.prompts, :count).by(1)
      end
    end
    context 'createアクションに失敗する' do
      it 'ipを登録していない' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        prompt_params = FactoryBot.attributes_for(:prompt).merge(category_id: @category_root.id)
        post prompts_path, params: { prompt: prompt_params }, xhr: true
        expect(response.status).to eq 302
      end
    end
  end
  describe 'GET /prompts/edit/id' do
    context 'editアクションに成功する' do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_prompt_path(@prompt.id), xhr: true, as: :js
        expect(response).to have_http_status(:success)
      end
      it 'editアクションにリクエストするとformに記入済みのpromptのテキストが存在する' do
        get edit_prompt_path(@prompt.id), xhr: true, as: :js
        expect(response.body).to include(@prompt.content)
      end
      it 'category_idを登録せずにeditアクションにリクエストするとformにroot_categoryの名前が存在する' do
        get edit_prompt_path(@prompt.id), xhr: true, as: :js
        expect(response.body).to include(@category_root.name)
      end
    end
    context 'editアクションに失敗する' do
      it 'ipを登録していない' do
        mock_blank_session = ActionController::TestSession.new(ip_id: nil)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
        get edit_prompt_path(@prompt.id), xhr: true, as: :js
        expect(response.status).to eq 302
      end
    end
    describe 'PUT /prompts/:id' do
      context 'updateアクションに成功する' do
        it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
          prompt_params = @prompt.attributes
          put prompt_path(@prompt.id), params: { prompt: prompt_params }, xhr: true, as: :js
          expect(response).to have_http_status(:success)
        end
        it 'updateアクションでtitleを編集すると更新されている' do
          prompt_params = @prompt.attributes
          prompt_params[:title] = "#{@prompt.title}_edited"
          old_title = @prompt.title
          put prompt_path(@prompt.id), params: { prompt: prompt_params }, xhr: true, as: :js
          expect(@prompt.reload.title).not_to eq(old_title)
        end
      end
      context 'updateアクションに失敗する' do
        it 'ipを登録していない' do
          mock_blank_session = ActionController::TestSession.new(ip_id: nil)
          allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
          prompt_params = @prompt.attributes
          put prompt_path(@prompt.id), params: { prompt: prompt_params }, xhr: true, as: :js
          expect(response.status).to eq 302
        end
      end
    end
    describe 'DELETE /prompts/:id' do
      context 'destroyアクションに成功する' do
        it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
          delete prompt_path(@prompt.id)
          expect(response).to redirect_to action: 'index'
        end
        it 'destroyアクションにリクエストすると、データが消去される' do
          expect { delete prompt_path(@prompt.id) }.to change(@ip.prompts, :count).by(-1)
        end
      end
      context 'destroyアクションに失敗する' do
        it 'ipを登録していない' do
          mock_blank_session = ActionController::TestSession.new(ip_id: nil)
          allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_blank_session)
          delete prompt_path(@prompt.id)
          expect(response.status).to eq 302
        end
      end
    end
  end
end
