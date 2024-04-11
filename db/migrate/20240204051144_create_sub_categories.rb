class CreateSubCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :is_active, default: true
      t.references :category
      t.timestamps
    end
  end
end
