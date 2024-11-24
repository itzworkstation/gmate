# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  enum state: { available: 0, in_use: 1 }
  enum measurement_unit: { pouch: 0, grm: 1, kg: 2, ltr: 3, ml: 4, pack: 5 }
  belongs_to :product
  belongs_to :store
  belongs_to :brand, required: false
  after_save :update_product_count
  after_destroy :update_product_count

  private
  def update_product_count
    store.update_products_count
  end
end
