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
      it 'nick_nameなしでは投稿できない' do
        @prompt.nick_name = ''
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include "Nick name can't be blank"
      end
      it 'contentなしでは投稿できない' do
        @prompt.content = ''
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include "Content can't be blank"
      end
      it 'ai指定なしでは投稿できない' do
        @prompt.ai_id = 0
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Ai must exist'
      end
      it 'ipを特定できていないと投稿できない' do
        @prompt.ip = nil
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Ip must exist'
      end
      it 'categoryを指定しないと投稿できない' do
        @prompt.category = nil
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Category must exist'
      end
      it 'titleが31文字以上では投稿できない' do
        @prompt.title = Faker::Alphanumeric.alphanumeric(number: 32)
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Title is too long (maximum is 30 characters)'
      end
      it 'nick_nameが31文字以上では投稿できない' do
        @prompt.nick_name = Faker::Alphanumeric.alphanumeric(number: 32)
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Nick name is too long (maximum is 30 characters)'
      end
      it 'contentが3001文字以上では投稿できない' do
        @prompt.content = Faker::Alphanumeric.alphanumeric(number: 3200)
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Content is too long (maximum is 3000 characters)'
      end
      it 'contentが4文字以下では投稿できない' do
        @prompt.content = Faker::Alphanumeric.alphanumeric(number: 3)
        @prompt.valid?
        expect(@prompt.errors.full_messages).to include 'Content is too short (minimum is 5 characters)'
      end
    end
  end
end
