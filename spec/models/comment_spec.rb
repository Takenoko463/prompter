require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント投稿' do
    context 'コメント投稿をできるとき' do
      it 'nick_name,content,ip,promptを持っている' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿をできないとき' do
      it 'nick_nameなしでは投稿できない' do
        @comment.nick_name = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Nick name can't be blank"
      end
      it 'contentなしでは投稿できない' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Content can't be blank"
      end
      it 'ipを特定できていないと投稿できない' do
        @comment.ip = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'Ip must exist'
      end
      it 'promptを特定できていないと投稿できない' do
        @comment.prompt = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include 'Prompt must exist'
      end
    end
  end
end
