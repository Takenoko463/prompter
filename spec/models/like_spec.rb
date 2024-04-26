require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end
  describe 'いいね投稿' do
    context 'いいね投稿できるとき' do
      it 'ip_md5_head8を持つ、promptと結びつきがある' do
        expect(@like).to be_valid
      end
    end
    context 'いいね投稿をできないとき' do
      it 'ipを特定できない' do
        @like.ip_md5_head8 = ''
        @like.valid?
        expect(@like.errors.full_messages).to include "Ip md5 head8 can't be blank"
      end
      it 'promptと結びつきを持たない' do
        @like.prompt = nil
        @like.valid?
        expect(@like.errors.full_messages).to include 'Prompt must exist'
      end
      it 'ipとpromptが重複してはいけない' do
        @like.save
        another_like = FactoryBot.build(:like)
        another_like.ip_md5_head8 = @like.ip_md5_head8
        another_like.prompt = @like.prompt
        another_like.valid?
        expect(another_like.errors.full_messages).to include 'Ip md5 head8 has already been taken'
      end
    end
  end
end
