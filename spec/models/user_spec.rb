require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'John Doe') }

    it 'returns the most recent 3 posts' do
      older_post = Post.create(author: user, created_at: 2.days.ago)
      newest_post = Post.create(author: user, created_at: Time.current)
      middle_post = Post.create(author: user, created_at: 1.day.ago)

      expect(user.recent_posts).to eq([newest_post, middle_post, older_post])
    end

    it 'limits the number of posts to 3' do
      5.times { Post.create(author: user) }

      expect(user.recent_posts.length).to eq(3)
    end
  end
end
