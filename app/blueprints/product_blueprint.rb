class ProductBlueprint < Blueprinter::Base
  identifier :id

  # fields :name 
  view :only_name do
    fields :name
  end

  field(:name) do |sp, options|
    sp.product.name
  end
end