# config/initializers/app_config.rb

require 'base64'
require 'json'

if ENV['GOOGLE_STORAGE_CREDENTIALS_BASE64']
  # Decode the Base64 string
  decoded_json = Base64.decode64(ENV['GOOGLE_STORAGE_CREDENTIALS_BASE64'])
  file_path = Rails.root.join('tmp', 'gcp_storage_credentials.json')
  # Write content to the file
  File.open(file_path, 'w') do |file|
    file.write(decoded_json)
  end
  
  ENV['GOOGLE_STORAGE_CREDENTIALS'] = 'tmp/gcp_storage_credentials.json'
else
  Rails.logger.warn("BASE64_CONFIG environment variable is missing!")
end
