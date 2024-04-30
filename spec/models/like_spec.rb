require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end
  describe 'いいね投稿' do
    context 'いいね投稿できるとき' do
      it 'ip、promptと結びつきがある' do
        expect(@like).to be_valid
      end
    end
    context 'いいね投稿をできないとき' do
      it 'ipを特定できない' do
        @like.ip = nil
        @like.valid?
        expect(@like.errors.full_messages).to include 'Ip must exist'
      end
      it 'promptと結びつきを持たない' do
        @like.prompt = nil
        @like.valid?
        expect(@like.errors.full_messages).to include 'Prompt must exist'
      end
      it '同じpromptに2回投稿できない' do
        @like.save
        another_like = FactoryBot.build(:like, ip: @like.ip, prompt: @like.prompt)
        another_like.valid?
        expect(another_like.errors.full_messages).to include 'Prompt has already been taken'
      end
    end
  end
end
