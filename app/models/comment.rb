class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_CommentsCounter

  def increment_CommentsCounter
    post.increment!(:CommentsCounter)
  end
end
