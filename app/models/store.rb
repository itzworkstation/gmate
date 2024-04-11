class Store < ApplicationRecord
  validates :name, presence: true, no_tags: true
  validates :name, uniqueness: {scope: :account_id}
  belongs_to :account, required: true
  has_many :store_products
  has_many :products, through: :store_products
end
