require 'rails_helper'

RSpec.describe Ip, type: :model do
  before do
    @ip = FactoryBot.build(:ip)
  end
  describe 'ip登録' do
    context 'ip登録' do
      it 'ip_md5_head8を持つ' do
        expect(@ip).to be_valid
      end
    end
    context 'ip登録不可' do
      it 'ip_md5_head8が空では登録できない' do
        @ip.ip_md5_head8 = ''
        @ip.valid?
        expect(@ip.errors.full_messages).to include "Ip md5 head8 can't be blank"
      end
      it 'ip_md5_head8は8文字でないといけない' do
        @ip.ip_md5_head8 = Faker::Alphanumeric.alphanumeric(number: 3)
        @ip.valid?
        expect(@ip.errors.full_messages).to include 'Ip md5 head8 is the wrong length (should be 8 characters)'
      end
      it 'ipを重複登録できない' do
        @ip.save
        another_ip = FactoryBot.build(:ip, ip_md5_head8: @ip.ip_md5_head8)
        another_ip.valid?
        expect(another_ip.errors.full_messages).to include 'Ip md5 head8 has already been taken'
      end
    end
  end
end
