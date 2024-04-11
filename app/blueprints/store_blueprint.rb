class StoreBlueprint < Blueprinter::Base
  identifier :id

  fields :name
  
  field :products_count do |store, options|
    store.store_products.count
  end
  
end