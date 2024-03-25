class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    @user_info = {
      id: current_user.id,
      name: current_user.name,
      email: current_user.email,
      admin: current_user.admin,
      image: {
        url: current_user.image.attached? ? url_for(current_user.image) : nil
      },
      created_month_year: current_user.created_at.strftime('%B %Y')
    }
    render json: @user_info
  end

  def add_image
    if params[:image].present?
      current_user.image.attach(params[:image])
      render json: { status: :ok, message: "Image uploaded successfully." }, status: :ok
    else
      render json: { status: :unprocessable_entity, message: "No image file provided." }, status: :unprocessable_entity
    end
  end
end
