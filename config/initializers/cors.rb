Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001' # your Next.js port
    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
  end
end
# This configuration allows CORS requests from the specified origin
# and permits all headers and methods for the resources.