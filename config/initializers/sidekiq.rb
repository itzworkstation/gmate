# config/initializers/sidekiq.rb
# 

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_server do |config|
  ENV['GOOGLE_STORAGE_CREDENTIALS']
end