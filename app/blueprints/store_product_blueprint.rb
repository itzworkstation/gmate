class StoreProductBlueprint < Blueprinter::Base
  identifier :id
  field(:name) do |sp, options|
    sp.product.name
  end

  field(:state) do |sp, options|
    'stocked'
  end
  fields :measurement, :measurement_unit, :expire_days, :measurement_unit_count
  
end