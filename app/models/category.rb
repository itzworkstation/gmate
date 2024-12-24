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
    Rails.cache.fetch("category_#{self.cache_version}_thumbnail") do
      image.variant(resize_to_limit: [100, 100]).processed if image_attached?
    end
    rescue
      puts "delete #{name}"
  end

  private

  def generate_variants
    # Generate and store the thumbnail variant
    GenerateVariantJob.perform_later(self.id)
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
