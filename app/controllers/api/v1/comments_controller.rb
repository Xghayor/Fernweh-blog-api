class Api::V1::CommentsController < ApplicationController
    load_and_authorize_resource
    before_action :set_post
    before_action :set_comment, only: [:destroy]
  
    def create
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
  
      if @comment.save
        render json: { message: "Comment created successfully" }, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment.destroy
      render json: { message: "Comment deleted successfully" }
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
  