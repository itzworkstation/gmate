# frozen_string_literal: true

class SubCategory < ApplicationRecord
  validates :name, presence: true, no_tags: true
  belongs_to :category, required: true
  has_many :products, dependent: :destroy
  has_many :brand_sub_categories
  has_many :brands, through: :brand_sub_categories
  
  scope :by_category, ->(category_id = nil) {
    category_id.present? ? where(category_id: category_id) : all
  }

  scope :search, ->(query) {
    where("name ILIKE :query", query: "%#{query}%") if query.present?
  }

  scope :by_category_and_search, ->(category_id = nil, query = nil) {
    by_category(category_id).merge(search(query))
  }
end
