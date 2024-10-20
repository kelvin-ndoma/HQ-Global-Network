class UsersController < ApplicationController
    include CurrentUserConcern
  
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authorize_user!, only: [:show, :update]
    before_action :authorize_admin!, only: [:destroy]
  
    def show
      render json: @user, include: [:groups, :events, :posts]
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found." }, status: :not_found
    end
  
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found." }, status: :not_found
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  
    def destroy
      @user.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found." }, status: :not_found
    rescue StandardError => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found." }, status: :not_found
    end
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :bio, :photo)
    end
  
    def authorize_user!
      unless @user == current_user
        render json: { error: "You are not authorized to perform this action." }, status: :forbidden
      end
    end
  
    def authorize_admin!
      unless current_user&.admin?
        render json: { error: "You are not authorized to perform this action." }, status: :forbidden
      end
    end
  end
  