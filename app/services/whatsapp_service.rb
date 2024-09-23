# frozen_string_literal: true

# app/services/whatsapp_service.rb

class WhatsappService
  BASE_URL = 'https://api.msg91.com'
  WHATSAPP_AUTH_KEY = ENV.fetch('WHATSAPP_AUTH_KEY', nil)
  API_ENDPOINT = '/api/v5/whatsapp/whatsapp-outbound-message/bulk/'
  INTEGRATED_NUMBER = '917668253009'
  TEMPLATE_NAME = 'otp_template'
  LANGUAGE_CODE = 'en'
  POLICY = 'deterministic'

  def self.send_otp(to:, otp_code:)
    response = http_service.post(
      API_ENDPOINT,
      payload: request_payload(to, otp_code),
      headers: { 'authkey' => WHATSAPP_AUTH_KEY }
    )
    
    handle_response(response)
  end

  private

  def self.http_service
    HttpService.new(base_url: BASE_URL)
  end

  def self.request_payload(to, otp_code)
    {
      integrated_number: INTEGRATED_NUMBER,
      content_type: 'template',
      payload: {
        messaging_product: 'whatsapp',
        type: 'template',
        template: {
          name: TEMPLATE_NAME,
          language: {
            code: LANGUAGE_CODE,
            policy: POLICY
          },
          namespace: nil,
          to_and_components: [
            {
              to: [to],
              components: {
                body_1: {
                  type: 'text',
                  value: otp_code
                },
                button_1: {
                  subtype: 'url',
                  type: 'text',
                  value: otp_code
                }
              }
            }
          ]
        }
      }
    }
  end

  def self.handle_response(response)
    if response.success?
      puts response.body
    else
      puts "Request failed with status #{response.status}: #{response.body}"
    end
  end
end
