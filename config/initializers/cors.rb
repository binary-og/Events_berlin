Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # your REACT port
    resource '*', headers: :any, methods: %i[get post put patch delete options head]
  end
end

# This configuration allows CORS requests from the specified origin
# and permits all headers and methods for the resources.
