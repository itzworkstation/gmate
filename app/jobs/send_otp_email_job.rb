class SendOtpEmailJob < ApplicationJob
  queue_as :default
  def perform(opts)
    AccountOtpMailer.with(opts).send_otp_email.deliver_now
  end
end
