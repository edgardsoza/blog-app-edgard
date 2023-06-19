class PostsController < ApplicationController
  def index
    # Placeholder logic or retrieve all posts for the user with the given ID from the database
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def show
    # Placeholder logic or retrieve the post with the given post_id for the user with the given user_id from the database
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end
end
