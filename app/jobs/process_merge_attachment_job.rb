# app/jobs/upload-invoice_job.rb
require 'mini_magick'
class ProcessMergeAttachmentJob < BaseJob
  # queue_as :merge_attachments
  sidekiq_options unique: :until_executed, lock: :until_executed
  # call it UploadInvoiceJob.perform_later(2)
  def perform(invoice_id, klass)
    invoice = Invoice.find invoice_id
    # Ensure there are avatars to merge
    return unless invoice.merge_attachment.attached?
    process_attachment(invoice)
  end
  private

  def process_attachment(invoice)
    
    image = MiniMagick::Image.read(invoice.merged_attachment.download)

    puts "I am in image process"
  end

  def find_job_statusable(job)
    job.arguments.last.classify.constantize.find(job.arguments.first)  # You can adjust this logic based on your actual job arguments
  end
end
