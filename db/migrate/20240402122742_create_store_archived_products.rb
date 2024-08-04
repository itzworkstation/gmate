# frozen_string_literal: true

class CreateStoreArchivedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :store_archived_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :used_in_days, default: 1
      t.integer :actual_used_in_days, default: 10
      t.integer :state, default: 0
      t.integer :measurement
      t.datetime :used_at
      t.integer :measurement_unit
      t.integer :measurement_unit_count, default: 1
      t.boolean :is_pack, default: true
      t.references :brand
      t.timestamps
    end
  end
end
