Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://127.0.0.1:5173', 'http://localhost:5173', 'https://hq-global-network.onrender.com'
    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true  # Enable credentials (cookies, session data)
  end

  # Uncomment this block when you deploy your frontend
  # allow do
  #   origins 'https://your-frontend-domain.com'  # Update this to your actual frontend URL once deployed
  #   resource '*', 
  #     headers: :any, 
  #     methods: [:get, :post, :put, :patch, :delete, :options, :head],
  #     credentials: true
  # end
end
