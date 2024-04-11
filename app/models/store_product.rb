class StoreProduct < ApplicationRecord
  enum state: { available: 0, in_use: 1 }
  belongs_to :product
  belongs_to :store
end
