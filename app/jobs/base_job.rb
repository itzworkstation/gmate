# app/jobs/base_job.rb
class BaseJob < ActiveJob::Base
  around_perform do |job, block|
    job_statusable = find_job_statusable(job)
    # Set job status to 'started' before the job begins
    update_job_status(job, job_statusable, 'started')

    begin
      # Perform the actual job by calling the block
      block.call
      # Update job status to 'completed' after successful job execution
      update_job_status(job, job_statusable, 'completed')

    rescue => e
      # If an error occurs, update status to 'failed' and capture the error message
      update_job_status(job, job_statusable, 'failed', e.message)
      raise e  # Re-raise the exception so Sidekiq knows it failed
    end
  end

  # The actual job to perform
  def perform(*args)
    raise 'This method should be implemented in child classes'
  end
  

  private

  # Method to update job status
  def update_job_status(job, job_statusable, status, error_message = nil)
    job_id = job.job_id  # Access the job's JID (Job ID)
    # Create or update the JobStatus record with polymorphic association
    job_status = JobStatus.find_or_initialize_by(job_id: job_id, job_statusable: job_statusable)
    job_status.status = status
    job_status.error_message = error_message if error_message
    job_status.save
  end
end
