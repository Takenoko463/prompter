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
    @prompt = FactoryBot.build(:prompt, category: @category_root, ip: @ip)
  end
  describe 'GET /prompts' do
    before 'promptを登録済' do
      @prompt.save
    end
    subject do
      get prompts_path
    end
    context 'indexアクションに成功する' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
        is_expected.to eq 200
        expect(response.body).to include(@prompt.content)
      end
    end
    context 'indexアクションに失敗する' do
      context 'ip未登録でindexアクションを行う' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'GET /prompts/new' do
    subject do
      get new_prompt_path, xhr: true, as: :js
    end
    context 'newアクションに成功する' do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
      end
    end
    context 'newアクションに失敗する' do
      context 'ip未登録でnewアクションを行う' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'POST /prompts' do
    let(:params) { @prompt.attributes }
    subject { post prompts_path, params: { prompt: params }, xhr: true, as: :js }
    context 'createアクションに成功する' do
      context 'valid_params' do
        it 'returns http success' do
          is_expected.to eq 200
          expect(response).to have_http_status(:success)
        end
        it 'create prompt' do
          expect { subject }.to change(@ip.prompts, :count).by(1)
        end
        it 'include prompt' do
          is_expected.to eq 200
          expect(response.body).to include(@prompt.content)
        end
      end
      context 'no answer' do
        let(:params) do
          @prompt[:answer] = ''
          @prompt.attributes
        end
        it 'create prompt' do
          expect { subject }.to change(@ip.prompts, :count).by(1)
        end
      end
    end
    context 'createアクションに失敗する' do
      context 'ipを登録せずにpost' do
        include_examples 'not_authenticate_ip_test'
      end
      context 'invalid params' do
        let(:params) do
          @prompt[:content] = ''
          @prompt.attributes
        end
        it 'returns http failed' do
          is_expected.to eq 422
        end
        it 'create no prompt' do
          expect { subject }.to change(@ip.prompts, :count).by(0)
        end
      end
    end
  end
  describe 'GET /prompts/edit/id' do
    before 'prompt登録' do
      @prompt.save
    end
    subject { get edit_prompt_path(@prompt.id), xhr: true, as: :js }
    context 'editアクションに成功する' do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
      end
      it 'editアクションにリクエストするとformに記入済みのpromptのテキストが存在する' do
        is_expected.to eq 200
        expect(response.body).to include(@prompt.content)
      end
    end
    context 'editアクションに失敗する' do
      context 'ipを登録せずにedit' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'PUT /prompts/:id' do
    before 'prompt登録' do
      @prompt.save
    end
    let(:params) do
      prompt_params = @prompt.attributes
      prompt_params[:title] = "#{@prompt.title}_edited"
      prompt_params
    end
    subject { put prompt_path(@prompt.id), params: { prompt: params }, xhr: true, as: :js }
    context 'updateアクションに成功する' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
        expect(response).to have_http_status(:success)
      end
      it 'updateアクションでtitleを編集すると更新されている' do
        is_expected.to eq 200
        expect(@prompt.title).not_to eq(@prompt.reload.title)
      end
    end
    context 'updateアクションに失敗する' do
      context 'ipを登録せずにupdate' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'DELETE /prompts/:id' do
    before 'prompt登録' do
      @prompt.save
    end
    subject { delete prompt_path(@prompt.id) }
    context 'destroyアクションに成功する' do
      it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 302
        expect(response).to redirect_to action: 'index'
      end
      it 'destroyアクションにリクエストすると、データが消去される' do
        expect { subject }.to change(@ip.prompts, :count).by(-1)
      end
    end
    context 'destroyアクションに失敗する' do
      context 'ipを登録せずにdestroy' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'GET /prompts/search' do
    context 'searchアクションに成功する' do
      it 'searchアクションにリクエストすると正常にレスポンスが返ってくる' do
        get search_prompts_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
