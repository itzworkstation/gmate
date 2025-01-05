# app/jobs/upload-invoice_job.rb
require 'mini_magick'
class MergeAttachmentsJob < BaseJob
  # queue_as :merge_attachments
  sidekiq_options unique: :until_executed, lock: :until_executed
  # call it UploadInvoiceJob.perform_later(2)
  def perform(invoice_id, klass)
    invoice = Invoice.find invoice_id
    # Ensure there are avatars to merge
    return unless invoice.attachments.attached?

    # Download the avatar images and prepare them for merging
    
    images = invoice.attachments.map { |attachment| MiniMagick::Image.read(attachment.download) }
    tmp_file_name= "merged_attachment_#{Time.now.to_i}.jpg"
    temp_file = Rails.root.join('tmp', tmp_file_name)
    system "magick convert #{images.map(&:path).join(' ')} -append #{temp_file}"

    # Attach the merged image to the user
    invoice.merged_attachment.attach(io: File.open(temp_file), filename: tmp_file_name, content_type: 'image/jpeg')

    # Clean up the temporary file
    File.delete(temp_file)
  end
  private

  def find_job_statusable(job)
    job.arguments.last.classify.constantize.find(job.arguments.first)  # You can adjust this logic based on your actual job arguments
  end
end
