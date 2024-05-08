require 'rails_helper'

RSpec.describe 'Comments', type: :request do
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
  before 'テストを動かしているipで、promptと、それに対するcommentを作成' do
    @prompt = FactoryBot.create(:prompt)
    @comment = FactoryBot.build(:comment, ip_id: @ip.id, prompt_id: @prompt.id)
  end
  describe 'GET /prompts/:prompt_id/comments' do
    before 'commentを登録済' do
      @comment.save
    end
    subject do
      get prompt_comments_path(@prompt)
    end
    context 'indexアクションに成功する' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのpromptのテキストが存在する' do
        is_expected.to eq 200
        expect(response.body).to include(@comment.content)
      end
    end
    context 'indexアクションに失敗する' do
      context 'ip未登録でindexアクションを行う' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'GET /prompts/:prompt_id/comments/new' do
    subject do
      get new_prompt_comment_path(@prompt), xhr: true, as: :js
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
  describe 'POST /prompts/:prompt_id/comments' do
    let(:params) { @comment.attributes }
    subject { post prompt_comments_path(@prompt), params: { comment: params }, xhr: true, as: :js }
    context 'createアクションに成功する' do
      context 'valid_params' do
        it 'returns http success' do
          is_expected.to eq 200
          expect(response).to have_http_status(:success)
        end
        it 'create comment' do
          expect { subject }.to change(@ip.comments, :count).by(1)
        end
        it 'include content' do
          is_expected.to eq 200
          expect(response.body).to include(@comment.content)
        end
      end
    end
    context 'createアクションに失敗する' do
      context 'ipを登録せずにpost' do
        include_examples 'not_authenticate_ip_test'
      end
      context 'invalid params' do
        let(:params) do
          @comment[:content] = ''
          @comment.attributes
        end
        it 'returns http failed' do
          is_expected.to eq 422
        end
        it 'create no prompt' do
          expect { subject }.to change(@ip.comments, :count).by(0)
        end
      end
    end
  end
  describe 'GET /comments/:id/edit' do
    before 'comment登録' do
      @comment.save
    end
    subject { get edit_comment_path(@comment), xhr: true, as: :js }
    context 'editアクションに成功する' do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
      end
      it 'editアクションにリクエストするとformに記入済みのpromptのテキストが存在する' do
        is_expected.to eq 200
        expect(response.body).to include(@comment.content)
      end
    end
    context 'editアクションに失敗する' do
      context 'ipを登録せずにedit' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'PUT /prompts/:prompt_id/comments/:id' do
    before 'comment登録' do
      @comment.save
    end
    let(:params) do
      comment_params = @comment.attributes
      comment_params[:content] = "#{@comment.content}_edited"
      comment_params
    end
    subject { put prompt_comment_path(id: @comment.id, prompt_id: @prompt.id), params: { comment: params }, xhr: true, as: :js }
    context 'updateアクションに成功する' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        is_expected.to eq 200
        expect(response).to have_http_status(:success)
      end
      it 'updateアクションでtitleを編集すると更新されている' do
        is_expected.to eq 200
        expect(@comment.content).not_to eq(@comment.reload.content)
      end
    end
    context 'updateアクションに失敗する' do
      context 'ipを登録せずにupdate' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
  describe 'DELETE /prompts/:id' do
    before 'comment登録' do
      @comment.save
    end
    subject { delete comment_path(@comment) }
    context 'destroyアクションに成功する' do
      it 'destroyアクションにリクエストすると一覧ページに戻る' do
        is_expected.to eq 302
        expect(response).to redirect_to action: 'index', prompt_id: @prompt.id
      end
      it 'destroyアクションにリクエストすると、データが消去される' do
        expect { subject }.to change(@ip.comments, :count).by(-1)
      end
    end
    context 'destroyアクションに失敗する' do
      context 'ipを登録せずにdestroy' do
        include_examples 'not_authenticate_ip_test'
      end
    end
  end
end
