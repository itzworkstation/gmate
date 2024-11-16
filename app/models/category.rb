# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validates :slug, uniqueness: true
  has_many :sub_categories, dependent: :destroy

  scope :by_search, ->(query) {
    where("name ILIKE :query", query: "%#{query}%") if query.present?
  }
end
