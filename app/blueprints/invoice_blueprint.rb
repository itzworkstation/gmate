# frozen_string_literal: true

class InvoiceBlueprint < Blueprinter::Base
  identifier :id
  field :attachment_name do |invoice|
    invoice.attachment.name
  end

  field :created_at do |invoice|
    (DateTime.now - rand(10).days).strftime("%d-%b-%Y %I:%M %p")
  end

  fields :invoice_no, :products_count, :imported_count, :failed_count, :error_message, :state
end
