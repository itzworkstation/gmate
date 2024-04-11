class StoreArchivedProduct < ApplicationRecord
  enum state: { used: 0 }
  belongs_to :product
  belongs_to :store
end
