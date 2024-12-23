# config/initializers/sidekiq.rb
# 
if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:8900/0' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:8900/0' }
  end
end
