class Api::V1::LikeController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:id])
      @like = @post.likes.build(user: current_user)
  
      if @like.save
        render json: @like, status: :created
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post = Post.find(params[:id])
      @like = @post.likes.find_by(user: current_user)
  
      if @like.present?
        @like.destroy
        head :no_content
      else
        render json: { error: "Like not found" }, status: :not_found
      end
    end
  end
  