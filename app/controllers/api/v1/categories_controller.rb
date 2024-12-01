# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < BaseController
      include Pagination
      def_param_group :category do
        param :category, Hash, desc: 'category parameters', required: true do
          param :name, String, desc: 'Category name', required: true
          param :slug, String, desc: 'Category slug', required: true
          param :photo, File, desc: 'Photo', required: false
          param :is_active, :boolean, desc: 'Category is active or not. Default is active',
                                      required: false
        end
      end

      api :GET, '/v1/categories', 'Get a list of categories'
      param :offset, String, required: false
      param :limit, String, required: false
      param :q, String, desc: 'search by query', required: false
      def index
        categories = Category.search(params[:q]).offset(offset).limit(limit)
        render_success({categories: CategoryBlueprint.render_as_json(categories), measurement_units: StoreProduct.measurement_units.keys.map(&:upcase)}, status: :ok, message: 'Success')
      end

      api :POST, '/v1/categories', 'Create a category'
      param_group :category
      def create
        category = Category.new(category_params)
        if category.save
          render_success(CategoryBlueprint.render_as_json(category), status: :ok, message: 'Success')
        else
          render_error(category.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      private

      def category_params
        params.require(:category).permit(:id, :name, :slug, :is_active, :image)
      end
    end
  end
end
