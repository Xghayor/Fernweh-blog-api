class Api::V1::UsersController < ApplicationController
    load_and_authorize_resource
  
    def profile
        @user_info = {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        image: current_user.image,
        created_month_year: current_user.created_at.strftime('%B %Y')
      }
      render json: @user_info
    end

    def add_image
        if current_user.update(image: params[:image])
          render json: { status: :ok, message: "Image uploaded successfully." }, status: :ok
        else
          render json: { status: :unprocessable_entity, message: "Failed to upload image." }, status: :unprocessable_entity
        end
      end  
  end
  