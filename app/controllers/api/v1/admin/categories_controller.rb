# frozen_string_literal: true

module Api
  module V1
    module Admin
      class CategoriesController < BaseController
        api :POST, '/v1/categories', 'Get all categories'
        def index
          categories = Category.all
          render_success(CategoryBlueprint.render_as_json(categories), status: :ok, message: 'Fetched successfully')
        end
      end
    end
  end
end
