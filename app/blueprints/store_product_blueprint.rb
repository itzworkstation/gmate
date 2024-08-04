# frozen_string_literal: true

class StoreProductBlueprint < Blueprinter::Base
  identifier :id
  field(:name) do |sp, _options|
    sp.product.name
  end

  field(:state) do |_sp, _options|
    'stocked'
  end
  fields :measurement, :measurement_unit, :expire_days, :measurement_unit_count
end
