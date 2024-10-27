class AddColumnLanguageToAccount < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :language, :string, default: 'en'
  end
end
