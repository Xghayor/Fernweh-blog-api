class Api::V1::CommentController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:id])
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      authorize! :destroy, @comment
      @comment.destroy
      head :no_content
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
  