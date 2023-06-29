module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show posts comments add_comment]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def posts
        @posts = @user.posts
        render json: @posts
      end

      def comments
        @comments = Comment.where(post_id: @user.posts.pluck(:id))
        render json: @comments
      end

      def add_comment
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user = @user

        if @comment.save
          render json: @comment, status: :created
        else
          render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
