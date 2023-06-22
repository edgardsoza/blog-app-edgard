class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id]) # Add this line to set the @user variable
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to user_post_url(@user, @post), notice: 'Liked successfully.'
    else
      redirect_to user_post_url(@user, @post), alert: 'Failed to like the post.'
    end
  end
end
