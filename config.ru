# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# Production namespace like `https://my_url/shiva/users`
map ENV['SHIVA_NAMESPACE'] if ENV['SHIVA_NAMESPACE']
run Rails.application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i(get post put patch delete options)
  end
end
