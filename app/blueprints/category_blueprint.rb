class CategoryBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :slug, :is_active
end