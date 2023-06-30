module Api
  module V1
    class CommentsController < ApplicationController
      def create
        post = Post.find(params[:post_id])
        comment = post.comments.new(comment_params)
        comment.user = current_user # Set the comment's owner as the current user

        if comment.save
          render json: comment, status: :created
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        post = Post.find(params[:post_id])
        comments = post.comments
        render json: comments
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
