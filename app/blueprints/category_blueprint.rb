# frozen_string_literal: true

class CategoryBlueprint < Blueprinter::Base
  identifier :id

  field :image_url do |cat|
    cat.image_thumbnail || Rails.application.routes.default_url_options[:host] + '/assets/categories/kitchen@3x.png'
  end

  fields :name, :slug, :is_active
end
