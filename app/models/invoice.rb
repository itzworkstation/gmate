class Invoice < ApplicationRecord
  has_one_attached :attachment
  enum state: { enqued: 0, inprogress: 1, uploaded: 2, failed: 3 }
  belongs_to :store, required: true
  has_one :job_status, as: :job_statusable
end
