require 'mailtrap'
require 'base64'
class AccountOtpMailer < ApplicationMailer
  default :from => 'admin@gmate.io'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_otp_email(opts)
    mail = Mailtrap::Mail::FromTemplate.new(
      from:
        {
          email: "mailtrap@demomailtrap.com",
          name: "Mailtrap Test",
        },
      to: [
        {
          email: "snlkumar1313@gmail.com",
        }
      ],
      template_uuid: ENV['OTP_TEMPLATE_ID'],
      template_variables: {
        "user_name" => 'sunil kumar',
        "otp_code" => '999999'
      }
    )
    client = Mailtrap::Client.new(api_key: ENV['MAILER_API_KEY'])
    client.send(mail)
  end
end
