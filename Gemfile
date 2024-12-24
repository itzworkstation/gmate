# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.5'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'active_model_otp'
gem 'apipie-rails'
gem 'bcrypt'
gem 'blueprinter'
gem 'faraday', '~> 1.5'
gem 'jwt'
gem 'kaminari'
gem 'oj'
gem 'puma', '6.4.3'
gem 'sendgrid-ruby'
gem 'sentry-rails'
gem 'sentry-ruby'
# lint gems
gem 'brakeman'
gem 'bundler-audit'
gem 'rubocop'
gem 'google-cloud-storage'
gem 'pagy'
gem 'sidekiq'
gem 'sidekiq-unique-jobs', '~> 8.0'
gem 'image_processing', '~> 1.2'
# gem 'ruby-vips'


# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
end
gem 'mailtrap'
group :development do
  gem 'letter_opener'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'sass-rails'

# b8de40d6de62148b59a5956d1bd12035
