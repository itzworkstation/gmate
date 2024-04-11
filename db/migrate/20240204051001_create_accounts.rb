class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
