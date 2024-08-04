# frozen_string_literal: true

class ProductBlueprint < Blueprinter::Base
  identifier :id

  # fields :name
  view :only_name do
    fields :name
  end

  field(:name) do |sp, _options|
    sp.product.name
  end
end
