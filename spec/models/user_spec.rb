require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'Test User', photo: 'photo.com', bio: 'Test User') }

  before { user.save }

  it 'validates presence of name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'validates that posts_counter is greater than or equal to 0' do
    user.posts_counter = -10
    expect(user).to_not be_valid
  end

  it 'validates that posts_counter is greater than or equal to 0' do
    user.posts_counter = 10
    expect(user).to be_valid
  end

  it 'returns the last three posts for the user' do
    expect(user.recent_posts).to eq([])
  end
end
