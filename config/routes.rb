Rails.application.routes.draw do
  get 'render/index'
  
  # Route for health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "render#index"
end
