# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'Gmate'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/api_doc'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
