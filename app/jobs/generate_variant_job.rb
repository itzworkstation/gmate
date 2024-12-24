# app/jobs/upload-invoice_job.rb
class GenerateVariantJob < BaseJob
  sidekiq_options unique: :until_executed, lock: :until_executed
  # call it UploadInvoiceJob.perform_later(2)
  def perform(cat_id)
    cat =Category.find cat_id
    cat.image.variant(:thumbnail).processed
  end
  private

  def find_job_statusable(job)
    Category.find(job.arguments.first)  # You can adjust this logic based on your actual job arguments
  end
end
