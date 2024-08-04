# frozen_string_literal: true

class StoreBlueprint < Blueprinter::Base
  identifier :id

  fields :name

  field :products_count do |store, _options|
    store.store_products.count
  end
end
