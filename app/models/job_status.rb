# app/models/job_status.rb
class JobStatus < ApplicationRecord
  belongs_to :job_statusable, polymorphic: true

  validates :job_id, presence: true
  validates :status, presence: true
end
