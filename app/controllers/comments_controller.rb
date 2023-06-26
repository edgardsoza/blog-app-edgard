class CommentsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_url(@post.author, @post), notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_post
    @post = Post.includes(:author).find(params[:post_id])
    @user = @post.author
  end

  def set_user
    @user = current_user
  end
end
