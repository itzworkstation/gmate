# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.boolean :is_active, default: true
      t.references :account, null: false
      t.timestamps
    end
  end
end
