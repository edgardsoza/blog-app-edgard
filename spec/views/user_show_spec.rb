require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'John', photo: 'https://via.placeholder.com/150', bio: 'Programmer',
                          posts_counter: 0)
      @post1 = Post.create(author: @user, title: 'First Test', text: 'This is my first post', likes_counter: 0,
                           comments_counter: 0)
      @post2 = Post.create(author: @user, title: 'Second Test', text: 'This is my second post', likes_counter: 0,
                           comments_counter: 0)
      @post3 = Post.create(author: @user, title: 'Third Test', text: 'This is my third post', likes_counter: 0,
                           comments_counter: 0)
      visit user_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='#{@user.photo}']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.posts_counter)
    end

    it "renders the user's bio" do
      expect(page).to have_content(@user.bio)
    end

    it 'renders 3 recent posts of the user' do
        expect(page).to have_content('Post #1')
        expect(page).to have_content('Post #2')
        expect(page).to have_content('Post #3')
    end

    it 'renders a button to redirect to posts page' do
      expect(page).to have_content('See all posts')
    end

    it "redirects to the user's posts index page" do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end