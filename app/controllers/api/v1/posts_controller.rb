class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]
  
  def index
    @posts = Post.all
    render json: @posts, include: [:comments, :likes]
  end

  def show
    render json: @post, include: [:comments, :likes]
  end

  def create
    authorize! :create, Post
    if current_user.admin?
      @post = current_user.posts.new(post_params)

      if @post.save
        render json: { message: "Post created successfully" }, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized: Only admins can create posts" }, status: :unauthorized
    end
  end

  def update
    authorize! :update, Post
    if current_user.admin?
      if @post.update(post_params)
        render json: { message: "Post updated successfully" }
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized: Only admins can update posts" }, status: :unauthorized
    end
  end

  def destroy
    authorize! :destroy, Post
    if current_user.admin?
      @post.destroy
      render json: { message: "Post deleted successfully" }
    else
      render json: { message: "Unauthorized: Only admins can delete posts" }, status: :unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
end
