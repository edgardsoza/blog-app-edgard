require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'User Test', photo: 'photo.com', bio: 'Test Like', posts_counter: 0) }
  let(:post) { Post.create(author_id: user.id, title: 'Test Title', text: 'Test Text', comments_counter: 0, likes_counter: 0) }
  let(:like) { Like.new(user_id: user.id, post: post) }

  before { like.save }

  it 'Likes counter should increment for posts' do
    prev_counter = like.post.likes_counter
    like.post.increment(:likes_counter).save
    expect(like.post.likes_counter).to eq(prev_counter + 1)
  end
end
