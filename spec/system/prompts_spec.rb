require 'rails_helper'

RSpec.describe 'Prompts', type: :system do
  before '現在のip' do
    @current_ip_plain = '127.0.0.1'
    @current_ip = FactoryBot.build(:ip, ip_md5_head8: Digest::MD5.hexdigest(@current_ip_plain)[0, 8])
  end
  before '他のipをデータベースに登録' do
    @another_ip_plain_v4 = Faker::Internet.ip_v4_address
    @ip_v4 = FactoryBot.create(:ip, ip_md5_head8: Digest::MD5.hexdigest(@another_ip_plain_v4)[0, 8])
    @another_ip_plain_v6 = Faker::Internet.ip_v6_address
    @ip_v6 = FactoryBot.create(:ip, ip_md5_head8: Digest::MD5.hexdigest(@another_ip_plain_v6)[0, 8])
  end
  before 'categoryをrootから孫まで定義' do
    @category_root = FactoryBot.create(:category, id: 0, name: '全て', ancestry: nil)
    @category_child = FactoryBot.create(:category, id: 1, name: 'カテゴリ1', ancestry: '0')
    @category_grand_child = FactoryBot.create(:category, id: 2, name: 'カテゴリ2', ancestry: '0/1')
  end
  before '各種ipで、promptを作成' do
    @prompt_v4 = FactoryBot.create(:prompt, category: @category_child, ip: @ip_v4)
    @prompt_v6 = FactoryBot.create(:prompt, category: @category_grand_child, ip: @ip_v6)
  end

  describe 'prompt一覧ページを訪ねる' do
    context '一覧ページ表示に成功する' do
      it '一覧ページに初めて訪れる' do
        visit root_path
        expect(page).to have_content('プロンプト一覧')
        # prompt一覧ページ
        visit category_prompts_path(0)
        expect(page).to have_selector 'h1', text: 'プロンプト一覧'
        expect(page).to have_content(@category_root.name)
      end
      it '一覧ページ2回目' do
        # sessionに現在のipを記録している 現在はブラウザを閉じると消去される。　後日、sessionを3日保存する設定を導入予定。
        ip = FactoryBot.create(:ip)
        mock_session = ActionController::TestSession.new(ip_id: ip.id)
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mock_session)
        # 2回目
        visit category_prompts_path(0)
        expect(page).to have_selector 'h1', text: 'プロンプト一覧'
        expect(page).to have_content(@category_root.name)
      end
    end
    context '一覧ページを表示できない' do
      it '一覧ページにトップページを介さず初めて訪れる' do
        visit category_prompts_path(0)
        expect(page).to have_content('Prompterへようこそ')
      end
    end
  end
  describe 'prompt投稿ページを表示する' do
    context '投稿ページ表示に成功する' do
      it '投稿ページを初めて表示する' do
        visit root_path
        visit prompts_path
        find_by_id('promptFormButton').click
        sleep 1
        expect(page).to have_selector 'h5', text: 'Prompt投稿'
      end
    end
    context '投稿ページを表示できない' do
    end
  end
  describe 'prompt投稿を行う' do
    before '事前にトップページを訪ねている' do
      @current_ip.save
      @prompt = FactoryBot.build(:prompt, ip: @current_ip, category: @category_grand_child)
      visit root_path
    end
    context 'prompt投稿に成功する' do
      it 'root_categoryページから遷移してprompt投稿に成功する' do
        visit prompts_path
        find_by_id('promptFormButton').click
        sleep 1
        expect(page).to have_selector 'h5', text: 'Prompt投稿'
        fill_in 'prompt[title]', with: @prompt.title
        fill_in 'prompt[content]', with: @prompt.content
        fill_in 'prompt[answer]', with: @prompt.answer
        fill_in 'prompt[nick_name]', with: @prompt.nick_name
        select Ai.find(@prompt.ai_id).name, from: 'prompt[ai_id]'
        select @prompt.category.parent.name, from: 'category[parents]'
        select @prompt.category.name, from: 'category[children]'
        click_on('投稿する')
        sleep 1
        # トップページに遷移していることを確認する
        expect(page).to have_current_path(prompts_path)
        expect(page).to have_content(@prompt.content)
      end
      it '子供カテゴリページから遷移してprompt投稿に成功する' do
        # 2回目
        visit prompts_path
        find_by_id('promptFormButton').click
        sleep 1
        expect(page).to have_selector 'h5', text: 'Prompt投稿'
        fill_in 'prompt[title]', with: @prompt.title
        fill_in 'prompt[content]', with: @prompt.content
        fill_in 'prompt[answer]', with: @prompt.answer
        fill_in 'prompt[nick_name]', with: @prompt.nick_name
        select Ai.find(@prompt.ai_id).name, from: 'prompt[ai_id]'
        select @prompt.category.parent.name, from: 'category[parents]'
        select @prompt.category.name, from: 'category[children]'
        click_on('投稿する')
        sleep 1
        # トップページに遷移していることを確認する
        expect(page).to have_current_path(prompts_path)
        expect(page).to have_content(@prompt.content)
        expect(page).to have_content(Ai.find(@prompt.ai_id).name)
      end
    end
    context '投稿できない' do
      it '不備のある内容を投稿する' do
        visit prompts_path
        find_by_id('promptFormButton').click
        sleep 1
        expect(page).to have_selector 'h5', text: 'Prompt投稿'
        fill_in 'prompt[title]', with: @prompt.title
        fill_in 'prompt[content]', with: ''
        fill_in 'prompt[answer]', with: @prompt.answer
        fill_in 'prompt[nick_name]', with: @prompt.nick_name
        select Ai.find(@prompt.ai_id).name, from: 'prompt[ai_id]'
        select @prompt.category.parent.name, from: 'category[parents]'
        select @prompt.category.name, from: 'category[children]'
        click_on('投稿する')
        sleep 1
        # 投稿フォームが表示されていることを確認する
        expect(page).to have_selector 'h5', text: 'Prompt投稿'
      end
    end
  end
end
