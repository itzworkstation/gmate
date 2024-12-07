# frozen_string_literal: true

class StoreProductBlueprint < Blueprinter::Base
  identifier :id
  field(:name) do |sp, _options|
    sp.product.name
  end

  field(:brand) do |sp, _options|
    sp.brand&.name
  end

  field(:category) do |sp, _options|
    CategoryBlueprint.render_as_json(sp.product.sub_category.category)
  end

  field(:sub_category) do |sp, _options|
    SubCategoryBlueprint.render_as_json(sp.product.sub_category)
  end

  field :image_url do |product|
    Rails.application.routes.default_url_options[:host] + '/assets/categories/kitchen@3x.png'
  end

  fields :measurement, :measurement_unit, :days_to_consume, :measurement_unit_count, :start_to_consume, :expiry_date, :state
end
