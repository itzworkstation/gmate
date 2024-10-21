# frozen_string_literal: true

# app/services/jwt_service.rb

class JwtService
  HMAC_SECRET = Rails.application.secrets.secret_key_base || ENV.fetch('SECRET_KEY_BASE', nil)

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(decoded_token)
  end
end
