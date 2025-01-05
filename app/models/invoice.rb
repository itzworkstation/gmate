class Invoice < ApplicationRecord
  has_many_attached :attachments
  has_one_attached :merged_attachment
  enum state: { enqued: 0, inprogress: 1, uploaded: 2, failed: 3 }
  belongs_to :store, required: true
  has_one :job_status, as: :job_statusable
  after_commit :merge_attachments, on: :create
  after_commit :process_merged_attachment, on: :update

  private
  def merge_attachments
    MergeAttachmentsJob.perform_later(self.id, 'invoice')
  end

  def process_merged_attachment
    if merged_attachment.attached? && saved_change_to_attribute?(:merged_attachment)
      PostMergeProcessingJob.perform_later(self.id, 'invoice')
    end
  end
end
