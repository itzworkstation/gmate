# frozen_string_literal: true

class Account < ApplicationRecord
  attr_accessor :send_otp
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [100, 100]
  end
  has_one_time_password
  OTP_EXPIRY_TIME = 3.minutes
  validates :phone, presence: true, no_tags: true
  validates :phone, integer: { message: 'should be only digits' }
  validates :phone, uniqueness: true, length: { minimum: 10, maximum: 10 }
  validates :email, email: true
  has_many :referrals, class_name: 'Account', foreign_key: 'referred_by_id'

  # A user can be referred by another user
  belongs_to :referrer, class_name: 'Account', optional: true, foreign_key: 'referred_by_id'
  has_many :stores, dependent: :destroy
  after_commit :send_otp_with_email
  before_create :generate_reference_code
  after_commit :generate_variants, if: -> { image.attached? }

  def validate_otp?(otp)
    authenticate_otp(otp, drift: OTP_EXPIRY_TIME)
  end

  def image_thumbnail
    if self.image.attached?      
      begin
        varient_image = self.image.variant(resize_to_limit: [100, 100]).processed
        varient_image.service.url(varient_image.key, expires_in: 24.hours, filename: varient_image.filename, content_type: varient_image.content_type, disposition: 'attachment')
      rescue
          puts "thumbnail failed for account"
        Rails.application.routes.default_url_options[:host] + '/assets/accounts/profile.jpeg'
      end 
    end
  end

  private

  def generate_variants
    # Generate and store the thumbnail variant
    GenerateVariantJob.perform_later(self.id, 'account')
    # image.variant(:thumbnail).processed
  end

  def send_otp_with_email
    otp = otp_code
    if self.send_otp
      WhatsappService.send_otp(to: '91'+phone, otp_code: otp)
      SendOtpEmailJob.perform_later({email: email, name: name, otp_code: otp}) if email.present?
    end
  end

  def generate_reference_code
    self.reference_code = loop do
      random_code = SecureRandom.hex(8) # Generates a 16-character string
      break random_code unless Account.exists?(reference_code: random_code)
    end
  end
end
