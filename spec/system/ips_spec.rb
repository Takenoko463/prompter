require 'rails_helper'

RSpec.describe 'Ips', type: :system do
  before '他のipをデータベースに登録' do
    @another_ip_plain = Faker::Internet.ip_v4_address
  end
  context 'トップページに遷移できる時' do
    it '遷移先がトップページであり、カテゴリ一覧は表示されない' do
      visit root_path
      expect(page).to have_content('Prompterへようこそ')
      expect(page).to have_content('Prompter')
      expect(page).to have_content('プロンプト一覧')
      expect(page).to have_content('プロンプト投稿')
      expect(page).to_not have_button '.navbar-toggle'
    end
    it '別ipからでもトップページに遷移できる' do
      visit root_path
      allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip) { @another_ip_plain }
      visit root_path
      expect(page).to have_content('Prompterへようこそ')
      expect(page).to have_content('Prompter')
      expect(page).to have_content('プロンプト一覧')
      expect(page).to have_content('プロンプト投稿')
      expect(page).to_not have_button '.navbar-toggle'
    end
  end
end
