class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :is_active, default: true
      t.references :sub_category
      t.timestamps
    end
  end
end
