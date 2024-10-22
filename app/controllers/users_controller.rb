class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    render json: @user
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
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email, 
      :password, 
      :password_confirmation, 
      :photo, 
      :bio, 
      :city,
      :country,
      :skills,
      :interests,          # Moved this up
      :languages,          # Moved this up
      :website,            # Moved this up
      :social_links,       # Moved this up
      :company,            # Moved this up
      :job_title,          # Moved this up
      :experience_years    # Moved this up
    )
  end
end
