class RegistrationsController < ApplicationController
    def create
      user = User.new(user_params)
  
      # Ensure the user is assigned the role of 'normal_user' by default
      user.role = 'normal_user'
  
      if user.save
        session[:user_id] = user.id
        render json: {
          status: :created,
          user: user
        }, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :photo, :bio)
    end
  end
  