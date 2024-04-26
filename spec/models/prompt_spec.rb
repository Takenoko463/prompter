require 'rails_helper'

RSpec.describe Prompt, type: :model do
  before do
    @prompt = FactoryBot.build(:prompt)
  end
  describe 'Prompt投稿' do
    context '新規投稿できるとき' do
      it 'title,nick_name,content,ai_id,ip_md5_head8,category_idを持っている' do
        expect(@prompt).to be_valid
      end
    end
    context '新規投稿ができないとき' do
      it 'titleなしでは投稿できない' do
        @prompt.title = ''
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include "Title can't be blank"
      end
    end
  end
end
