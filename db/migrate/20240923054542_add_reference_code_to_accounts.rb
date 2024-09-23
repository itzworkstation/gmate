class AddReferenceCodeToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :reference_code, :string
    add_column :accounts, :referred_by_id, :integer
    add_index :accounts, :referred_by_id
    add_index :accounts, :reference_code
  end
end
