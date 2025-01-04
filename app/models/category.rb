# frozen_string_literal: true

class Category < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [100, 100]
  end
  validates :name, presence: true, no_tags: true
  validates :slug, :name, uniqueness: true
  has_many :sub_categories, dependent: :destroy
  after_commit :generate_variants, if: -> { image.attached? }

  

  scope :search, ->(query) {
    where("name ILIKE :query", query: "%#{query}%") if query.present?
  }

  def image_thumbnail
    if self.image.attached?      
      begin
        varient_image = self.image.variant(resize_to_limit: [100, 100]).processed
        varient_image.service.url(varient_image.key, expires_in: 24.hours, filename: varient_image.filename, content_type: varient_image.content_type, disposition: 'attachment')
      rescue
          puts "thumbnail failed for account"
        Rails.application.routes.default_url_options[:host] + '/assets/categories/kitchen@3x.png'
      end 
    end
  end

  private

  def generate_variants
    # Generate and store the thumbnail variant
    GenerateVariantJob.perform_later(self.id, 'category')
    # image.variant(:thumbnail).processed
  end

  def enqueue_upload_to_google_cloud
    return unless image_attached?

    # Enqueue the job to upload the image
    UploadImageToGoogleCloudJob.perform_later(self.id)
  end

  def image_attached?
    image.attached?  # This method checks if an image is attached
  end
end
