require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Edgard',
      bio: 'Programmer',
      photo: 'https://via.placeholder.com/150',
      posts_counter: 2
    )

    @user2 = User.create(
      name: 'Mar',
      bio: 'Programmer',
      photo: 'https://via.placeholder.com/150',
      posts_counter: 3
    )

    @post1 = Post.create(
      author_id: @user1.id,
      title: 'Jana',
      text: 'First Post',
      comments_counter: 1,
      likes_counter: 1
    )

    @comment1 = Comment.create(
      text: 'First Comment',
      post_id: @post1.id,
      user_id: @user1.id
    )

    @like1 = Like.create(
      post_id: @post1.id,
      user_id: @user1.id
    )
  end

  describe 'the post show page' do
    before(:each) do
      visit user_post_path(@user1, @post1)
    end

    it 'displays the post title' do
      expect(page).to have_content('Jana')
    end

    it 'displays the post author' do
      expect(page).to have_content('Edgard')
    end

    it 'displays the number of comments' do
      expect(page).to have_content('Comments: 2')
    end

    it 'displays the number of likes' do
      expect(page).to have_content('Likes: 2')
    end

    it 'displays the post text' do
      expect(page).to have_content('First Post')
    end

    it 'displays the commentor' do
      expect(page).to have_content('Edgard')
    end

    it 'displays the comment text' do
      expect(page).to have_content('First Comment')
    end
  end
end
