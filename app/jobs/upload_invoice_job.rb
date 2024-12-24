# app/jobs/upload-invoice_job.rb
class UploadInvoiceJob < BaseJob
  sidekiq_options unique: :until_executed, lock: :until_executed
  # call it UploadInvoiceJob.perform_later(2)
  def perform(invoice_id)
    puts "#{invoice_id} being processed in the background..."
    sleep(1 * 10)
    puts "i was sleeping..."
  end
  private

  def find_job_statusable(job)
    Invoice.find(job.arguments.first)  # You can adjust this logic based on your actual job arguments
  end
end
