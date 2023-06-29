class UsersController < ApplicationController
    def create
      user = User.new(user_params)
  
      if user.save
        session[:user_id] = user.id
        render json: user.slice(:id, :username, :image_url, :bio), status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
        if session[:user_id]
          user = User.find(session[:user_id])
          render json: user.slice(:id, :username, :image_url, :bio), status: :ok
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end
  
    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
  end
  