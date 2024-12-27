# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, presence: true, no_tags: true
  validates :name, uniqueness: { scope: :account_id }
  belongs_to :account, required: true
  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products
  has_many :invoices, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def update_products_count
    update(products_count: products.count)
  end
end
