# frozen_string_literal: true

# app/services/msg_service.rb

class MsgService
  def self.send_otp(to:, otp_code:)
    response = http_service.post('/dev/bulkV2',
                                 payload: { variables_values: otp_code, route: 'otp', numbers: to },
                                 headers: { 'Authorization' => ENV.fetch('MSG_SECRET_KEY', nil) })
    if response.success?
      puts response.body
    else
      puts "Request failed with status #{response.status}"
    end
  end

  def self.http_service
    HttpService.new(base_url: 'https://www.fast2sms.com')
  end
end
