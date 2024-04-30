require 'rails_helper'

RSpec.describe 'Ips', type: :system do
  context 'トップページに遷移できる時' do
    it '遷移先がトップページであり、カテゴリ一覧は表示されない' do
      visit root_path
      expect(page).to have_content('Prompterへようこそ')
      expect(page).to have_content('Prompter')
      expect(page).to have_content('プロンプト一覧')
      expect(page).to have_content('プロンプト投稿')
      expect(page).to_not have_button '.navbar-toggle'
    end
  end
end
