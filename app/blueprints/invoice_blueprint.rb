# frozen_string_literal: true

class InvoiceBlueprint < Blueprinter::Base
  identifier :id
  field :attachment_name do |invoice|
    invoice.merged_attachment.filename || invoice.attachments.map(&:filename).last
  end

  field :created_at do |invoice|
    invoice.updated_at.strftime("%d-%b-%Y %I:%M %p")
  end

  fields :invoice_no, :products_count, :imported_count, :failed_count, :error_message, :state
end
