class CreateStoreProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :store_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :used_in_days, default: 2
      t.integer :state, default: 0
      t.datetime :opened_at
      t.integer :measurement
      t.integer :measurement_unit
      t.integer :measurement_unit_count, default: 1
      t.references :brand
      t.timestamps
    end
  end
end
