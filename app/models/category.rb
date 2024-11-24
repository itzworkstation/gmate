# frozen_string_literal: true

class Category < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, no_tags: true
  validates :slug, :name, uniqueness: true
  has_many :sub_categories, dependent: :destroy

  scope :search, ->(query) {
    where("name ILIKE :query", query: "%#{query}%") if query.present?
  }

  def image_thumbnail
    image.variant(resize_to_limit: [100, 100]).processed if image_attached?
  end

  private

  def image_attached?
    image.attached?  # This method checks if an image is attached
  end
end
