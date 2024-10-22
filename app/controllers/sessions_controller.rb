class SessionsController < ApplicationController
  include CurrentUserConcern

  # Create a session for a logged-in user
  def create
    user = User.find_by(email: params.dig("user", "email"))

    if user&.authenticate(params.dig("user", "password"))
      session[:user_id] = user.id
      user.update(status: :active)  # Set status to 'active' when the user logs in
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # Check if the user is logged in
  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user
      }
    else
      render json: { logged_in: false }
    end
  end  

  # Logout the current user
  def logout
    if @current_user
      @current_user.update(status: :offline)  # Set status to 'offline' when the user logs out
      reset_session
      render json: {
        status: 200,
        logged_out: true,
        user_status: @current_user.status  # Return the user's updated status
      }
    else
      render json: {
        status: 400,
        error: "No user logged in"
      }
    end
  end

  # Update the current user's information
  def update
    if @current_user.update(user_params)
      render json: {
        status: :updated,
        user: @current_user
      }
    else
      render json: {
        error: @current_user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for user updates
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
