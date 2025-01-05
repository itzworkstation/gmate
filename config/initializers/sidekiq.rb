# config/initializers/sidekiq.rb
# 

Sidekiq.configure_server do |config|
  redis_config = { url: ENV['REDIS_URL'] }
  redis_config.merge!({ ssl: true, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }) if Rails.env.production?
  config.redis =redis_config
end

Sidekiq.configure_client do |config|
  redis_config = { url: ENV['REDIS_URL'] }
  redis_config.merge!({ ssl: true, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } } ) if Rails.env.production?
  config.redis = redis_config
end

Sidekiq.configure_server do |config|
  ENV['GOOGLE_STORAGE_CREDENTIALS']
end