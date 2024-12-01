# frozen_string_literal: true

class Category < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, no_tags: true
  validates :slug, :name, uniqueness: true
  has_many :sub_categories, dependent: :destroy
  # after_commit :enqueue_upload_to_google_cloud , on: :create

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

  def enqueue_upload_to_google_cloud
    return unless image_attached?

    # Enqueue the job to upload the image
    UploadImageToGoogleCloudJob.perform_later(self.id)
  end

  def image_attached?
    image.attached?  # This method checks if an image is attached
  end
end
