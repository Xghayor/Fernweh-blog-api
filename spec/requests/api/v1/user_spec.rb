require 'swagger_helper'

RSpec.describe 'api/v1/user', type: :request do
  include AuthHelper

  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }

  describe 'GET /' do
    before { get '/', headers: headers }

    it 'returns the user profile data' do
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['email']).to eq(user.email)
      expect(json['id']).to eq(user.id)
      expect(json['name']).to eq(user.name)
      expect(json['admin']).to eq(user.admin)

      if user.image.attached?
        expect(json['image']['url']).to eq(url_for(user.image))
      else
        expect(json['image']['url']).to be_nil
      end
      expect(json['created_month_year']).to eq(user.created_at.strftime('%B %Y'))
    end
  end
end
