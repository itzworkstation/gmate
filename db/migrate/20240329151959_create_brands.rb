# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
