# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'
require 'sprockets/railtie'
require "action_view/railtie"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# Load .env file in development and test environments
Dotenv.load if Rails.env.development? || Rails.env.test?

module Gmate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_lib(ignore: %w(assets tasks))
    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.active_job.queue_adapter     = :sidekiq
    # config.assets.enabled = true
    # This also configures session_options for use below
    config.session_store :cookie_store, key: "_your_app_session"

    # Required for all session management (regardless of session_store)
    config.middleware.use ActionDispatch::Cookies

    config.middleware.use config.session_store, config.session_options

    
  end
end
