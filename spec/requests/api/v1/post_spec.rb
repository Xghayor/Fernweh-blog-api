require 'swagger_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  include AuthHelper

  let(:admin_user) { create(:user, admin: true) }
  let(:regular_user) { create(:user) }
  let(:admin_headers) { auth_headers(admin_user) }
  let(:regular_headers) { auth_headers(regular_user) }

  describe 'GET /api/v1/posts' do
    it 'returns all posts with comments and likes' do
      create(:post)
      get '/api/v1/posts', headers: admin_headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
      expect(json[0]['comments']).to be_a(Array)
      expect(json[0]['likes']).to be_a(Array)
    end
  end

  describe 'GET /api/v1/posts/:id' do
    it 'returns a single post with comments and likes' do
      post = create(:post)
      get "/api/v1/posts/#{post.id}", headers: regular_headers
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(post.id)
      expect(json['comments']).to be_a(Array)
      expect(json['likes']).to be_a(Array)
    end
  end

  describe 'POST /api/v1/posts' do
    context 'when admin user' do
      it 'creates a new post' do
        expect {
          post '/api/v1/posts', params: { post: attributes_for(:post) }, headers: admin_headers
        }.to change(Post, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'PUT /api/v1/posts/:id' do
    let(:post) { create(:post) }

    context 'when admin user' do
      it 'updates the post' do
        put "/api/v1/posts/#{post.id}", params: { post: { title: 'Updated Title' } }, headers: admin_headers
        expect(response).to have_http_status(:success)
        expect(post.reload.title).to eq('Updated Title')
      end
    end
  end

  describe 'DELETE /api/v1/posts/:id' do
    let!(:post) { create(:post) }
      
    context 'when regular user' do
      it 'returns unauthorized' do
        expect {
          delete "/api/v1/posts/#{post.id}", headers: regular_headers
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
