# config/initializers/sidekiq.rb
# 
if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end
Sidekiq.configure_server do |config|
  ENV['GOOGLE_STORAGE_CREDENTIALS']
end