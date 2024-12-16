class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_no
      t.integer :products_count, default: 0
      t.integer :imported_count, default: 0
      t.integer :failed_count, default: 0
      t.string :error_message
      t.references :store
      t.integer :state, default: 0
      t.timestamps
    end
  end
end
