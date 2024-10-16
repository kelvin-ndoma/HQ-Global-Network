Rails.application.routes.draw do

  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  # Route for health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "render#home"
end
