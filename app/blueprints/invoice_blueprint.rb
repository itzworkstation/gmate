# frozen_string_literal: true

class InvoiceBlueprint < Blueprinter::Base
  identifier :id
  field :attachment_name do |invoice|
    invoice.attachment.filename
  end

  fields :invoice_no, :products_count, :imported_count, :failed_count, :error_message, :state
end
