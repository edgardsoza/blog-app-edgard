class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.includes(posts: { comments: :user }).find(params[:user_id])
    @post = @user.posts.includes(comments: :user).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])

    if can? :destroy, @post
      user = @post.author
      user.decrement!(:posts_counter)
      @post.likes.destroy_all
      @post.destroy
      redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
    else
      redirect_to user_post_path(@post.author_id, @post), alert: 'You are not authorized to delete this post.'
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_url(@user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
