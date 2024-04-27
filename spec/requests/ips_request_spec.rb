require 'rails_helper'

RSpec.describe 'Ips', type: :request do
  describe 'Create /ips' do
    it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      authenticate_or_request_with_http_basic(ENV['BASIC_AUTH_USER'], ENV['BASIC_AUTH_PASSWORD'])
      expect(response.status).to eq 200
    end
  end
end
