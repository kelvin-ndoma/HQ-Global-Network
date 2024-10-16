class SessionsController < ApplicationController

    # Create a session for a logged-in user

    def create
        user = User.find_by(email: params.dig("user", "email"))
    
        if user && user.authenticate(params.dig("user", "password"))
          session[:user_id] = user.id
          render json: {
            status: :created,
            logged_in: true,
            user: user
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

end