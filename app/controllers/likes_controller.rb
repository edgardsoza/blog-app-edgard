class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.build(user: current_user)
  
      if @like.save
        redirect_to @post, notice: 'Liked successfully.'
      else
        redirect_to @post, alert: 'Failed to like the post.'
      end
    end
  end
  