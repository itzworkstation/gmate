# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validates :slug, uniqueness: true
  has_many :sub_categories, dependent: :destroy
end
