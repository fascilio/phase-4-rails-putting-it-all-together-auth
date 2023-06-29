class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user.slice(:id, :username, :image_url, :bio), status: :ok
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end

    def destroy
        if session[:user_id]
          session.delete(:user_id)
          head :no_content
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end
end
  