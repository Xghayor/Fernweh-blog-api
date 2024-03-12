class Api::V1::LikesController < ApplicationController
    load_and_authorize_resource
  
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.new(user: current_user)
  
      if @like.save
        render json: { message: "Like created successfully" }, status: :created
      else
        render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @like = Like.find(params[:id])
  
      if @like.destroy
        render json: { message: "Like deleted successfully" }
      else
        render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  