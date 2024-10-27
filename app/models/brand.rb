# frozen_string_literal: true

class Brand < ApplicationRecord
  validates :name, presence: true, no_tags: true
  validates :name, uniqueness: true

  has_many :brand_sub_categories
  has_many :sub_categories, through: :brand_sub_categories

  scope :by_sub_categories, ->(sub_category_ids) {
    joins(:brand_sub_categories).where(brand_sub_categories: { sub_category_id: sub_category_ids }).distinct
  }

  scope :search, ->(query) {
    where("name ILIKE :query", query: "%#{query}%") if query.present?
  }

  scope :by_sub_categories_and_search, ->(sub_category_ids = [], query = nil) {
    by_sub_categories(sub_category_ids).merge(search(query))
  }
  
end
