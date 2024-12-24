# config/initializers/sidekiq.rb
# 

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], ssl: true, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], ssl: true, ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.configure_server do |config|
  ENV['GOOGLE_STORAGE_CREDENTIALS']
end