require 'swagger_helper'

RSpec.describe 'api/v1/user', type: :request do
    include AuthHelper
  
    let(:user) { create(:user) }
    let(:headers) { auth_headers(user) }
  
    describe 'GET /' do
      before { get '/', headers: headers }
  
      it 'returns the profile data' do
        expect(response).to have_http_status(:success)
        json= JSON.parse(response.body)
        expect(json['email']).to eq(user.email)
      end
    end
  end
  