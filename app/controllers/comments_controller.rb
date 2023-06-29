class CommentsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_post, only: %i[new create]
  before_action :set_comment, only: [:destroy]

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

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def destroy
    if can? :destroy, @comment
      @comment.destroy
      redirect_to user_post_path(@comment.post.user, @comment.post), notice: 'Comment deleted successfully.'
    else
      redirect_to user_post_path(@comment.post.user, @comment.post), alert: 'You are not authorized to delete this comment.'
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
