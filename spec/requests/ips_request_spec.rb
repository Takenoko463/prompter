require 'rails_helper'

RSpec.describe 'Ips', type: :request do
  describe 'Create /ips' do
    it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'createアクションにリクエストするとsessionにip_idが保存されている' do
      get root_path
      expect(session[:ip_id]).to be_a_kind_of(Integer)
    end
  end
end
