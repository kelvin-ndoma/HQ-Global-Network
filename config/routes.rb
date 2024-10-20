Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  patch '/sessions', to: 'sessions#update'

  # Add routes for users resource
  resources :users, only: [:show, :update, :destroy] # Add routes for show, update, and destroy

  # Route for health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "render#home"
end
