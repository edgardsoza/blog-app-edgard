require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Tom', photo: 'https://via.placeholder.com/150',
                          bio: 'Teacher from Mexico.',
                          posts_counter: 0)
      @post1 = Post.create(author: @user, title: 'First Post', text: 'This is my first post', likes_counter: 0,
                           comments_counter: 0)
      @post2 = Post.create(author: @user, title: 'Second Post', text: 'This is my second post', likes_counter: 0,
                           comments_counter: 0)
      @post3 = Post.create(author: @user, title: 'Third Post', text: 'This is my third post', likes_counter: 0,
                           comments_counter: 0)
      @post4 = Post.create(author: @user, title: 'Fourth Post', text: 'This is my fourth post', likes_counter: 0,
                           comments_counter: 0)
      @comment1 = Comment.create(user: @user, post: @post2, text: 'Comment 1')
      @comment2 = Comment.create(user: @user, post: @post2, text: 'Comment 2')
      @comment3 = Comment.create(user: @user, post: @post1, text: 'Comment 3')
      @comment4 = Comment.create(user: @user, post: @post1, text: 'Comment 4')
      @comment5 = Comment.create(user: @user, post: @post1, text: 'Comment 5')
      visit user_posts_path(@user)
    end

    it "renders user's profile picture" do
      find("img[src='https://via.placeholder.com/150']")
    end

    it "renders the user's username" do
      expect(page).to have_content(@user.name)
    end

    it "renders the user's post count" do
      expect(page).to have_content(@user.posts_counter)
    end

    it "renders the user's posts title" do
      expect(page).to have_content('First Post')
      expect(page).to have_content('Second Post')
      expect(page).to have_content('Third Post')
    end

    it "renders some of the post's body" do
      expect(page).to have_content(@post1.text[0, 50])
      expect(page).to have_content(@post2.text[0, 50])
      expect(page).to have_content(@post3.text[0, 50])
    end

    it 'renders first comments on a post' do
      expect(page).to have_content('Comment 1')
      expect(page).to have_content('Comment 2')
    end

    it 'renders comments count on a post' do
      expect(page).to have_content(@post1.comments_counter)
      expect(page).to have_content(@post2.comments_counter)
      expect(page).to have_content(@post3.comments_counter)
    end

    it 'renders likes count on a post' do
      expect(page).to have_content(@post1.likes_counter)
      expect(page).to have_content(@post2.likes_counter)
      expect(page).to have_content(@post3.likes_counter)
    end

    it 'renders pagination section if posts are more than 3' do
      expect(page).to have_content('See more')
    end

    it 'should redirect to the post show page' do
      visit user_posts_path(user_id: @user.id)
      [@post1, @post2].each do |post|
        click_link 'See more', href: user_post_path(user_id: @user.id, id: post.id)
        expect(page).to have_current_path(user_post_path(user_id: @user.id, id: post.id))
        visit user_posts_path(user_id: @user.id)
      end
    end
  end
end
