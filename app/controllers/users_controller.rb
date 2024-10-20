# app/controllers/users_controller.rb
class UsersController < ApplicationController
    include CurrentUserConcern
  
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authorize_user!, only: [:show, :update]
    before_action :authorize_admin!, only: [:destroy]
  
    def show
      render json: @user, include: [:groups, :events, :posts]
    end
  
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :bio, :photo)
    end
  
    def authorize_user!
      # Allow access only if the current user is the user being accessed
      unless @user == current_user
        render json: { error: "You are not authorized to perform this action." }, status: :forbidden
      end
    end
  
    def authorize_admin!
      # Allow access only if the current user is an admin
      unless current_user&.admin?
        render json: { error: "You are not authorized to perform this action." }, status: :forbidden
      end
    end
  end
  