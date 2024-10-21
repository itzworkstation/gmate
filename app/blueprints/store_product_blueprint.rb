# frozen_string_literal: true

class StoreProductBlueprint < Blueprinter::Base
  identifier :id
  field(:name) do |sp, _options|
    sp.product.name
  end

  field(:brand) do |sp, _options|
    sp.brand&.name
  end

  field(:state) do |_sp, _options|
    'stocked'
  end
  fields :measurement, :measurement_unit, :days_to_consume, :measurement_unit_count, :start_to_consume, :expiry_date
end
