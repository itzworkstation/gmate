class CreateBrandSubCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :brand_sub_categories do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
