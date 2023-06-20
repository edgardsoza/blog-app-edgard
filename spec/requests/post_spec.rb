require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let!(:user) { User.create(id: 1, name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
  let!(:post) { Post.create(id: 1, author: user, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 0) }

  describe 'GET /users/:user_id/posts' do
    it 'renders posts of a user' do
      get "/users/#{user.id}/posts"

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('Posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'renders a page for specific post' do
      get "/users/#{user.id}/posts/#{post.id}"

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include('Details')
    end
  end
end
