class RenameOldColumnNameInStoreProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :store_products, :used_in_days, :days_to_consume
    rename_column :store_products, :opened_at, :start_to_consume
    add_column :store_products, :expiry_date, :datetime
    add_column :store_products, :price, :decimal, precision: 7, scale: 2
    rename_column :store_archived_products, :used_in_days, :days_to_consume
    add_column :store_archived_products, :expiry_date, :datetime
    add_column :store_archived_products, :price, :decimal, precision: 7, scale: 2
    add_column :store_archived_products, :start_to_consume, :datetime
  end
end
