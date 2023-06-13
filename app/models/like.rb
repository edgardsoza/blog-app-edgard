class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_post_LikesCounter
    post.increment!(:LikesCounter)
  end
end
