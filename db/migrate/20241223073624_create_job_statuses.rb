class CreateJobStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :job_statuses do |t|
      t.string :job_id
      t.string :status
      t.text :error_message
      t.references :job_statusable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
