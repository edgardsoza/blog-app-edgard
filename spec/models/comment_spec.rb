require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'photo.com', bio: 'Test Comment', posts_counter: 0) }
  let(:post) do
    Post.create(author_id: user.id, title: 'Test', text: 'Text Test', comments_counter: 0,
                likes_counter: 0)
  end

  it 'belongs to a user' do
    expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'belongs to a post' do
    expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
  end

  it 'increments the comments counter of the associated post after creation' do
    expect do
      Comment.create(user:, post:)
    end.to change { post.reload.comments_counter }.by(1)
  end

  it 'increments the comments counter of the associated post when the comment is saved' do
    post.comments_counter = 0
    comment = Comment.new(user:, post:)
    comment.save

    expect(post.reload.comments_counter).to eq(1)
  end
end
