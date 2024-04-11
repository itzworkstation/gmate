class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :sub_category }
  validates :slug, uniqueness: true
  belongs_to :sub_category, required: true
  has_many :store_products
  has_many :stores, through: :store_products
  before_save :validate_slug
  private
  def validate_slug
    self.slug = SecureRandom.hex(6) if self.slug.nil?
  end
end
