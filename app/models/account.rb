# frozen_string_literal: true

class Account < ApplicationRecord
  has_one_time_password
  validates :name, :phone, presence: true, no_tags: true
  validates :phone, integer: { message: 'should be only digits' }
  validates :phone, uniqueness: true, length: { minimum: 10, maximum: 10 }
  validates :email, email: true
  has_many :stores, dependent: :destroy
  after_commit :send_otp_with_email, on: :create

  private

  def send_otp_with_email
    otp = otp_code
    MsgService.send_otp(to: phone, otp_code: otp)
    # SendOtpEmailJob.perform_later({email: email, name: name, otp_code: otp}) if email.present?
  end
end
