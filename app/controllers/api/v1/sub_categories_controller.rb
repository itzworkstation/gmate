# frozen_string_literal: true

module Api
  module V1
    class SubCategoriesController < BaseController
      def_param_group :sub_category do
        param :sub_category, Hash, desc: 'sub_category parameters', required: true do
          param :name, String, desc: 'sub_category name', required: true
          param :slug, String, desc: 'sub_category slug', required: true
          param :category_id, String, desc: 'category_id', required: true
          param :is_active, :boolean, desc: 'sub_category is active or not. Default is active',
                                      required: false
        end
      end

      api :GET, '/v1/sub_categories', 'Get a list of sub_category'
      param :category_id, String, desc: 'category_id', required: false
      param :q, String, desc: 'search by query', required: false
      def index
        sub_categories = SubCategory.by_category_and_search(params[:category_id], params[:q])
        render_success(CategoryBlueprint.render_as_json(sub_categories), status: :ok, message: 'Success')
      end

      api :POST, '/v1/sub_categories', 'Create an account'
      param_group :sub_category
      def create
        sub_category = SubCategory.new(sub_category_params)
        if sub_category.save
          render_success(CategoryBlueprint.render_as_json(sub_category), status: :ok, message: 'Success')
        else
          render_error(sub_category.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      api :GET, '/v1/brands', "Get a list of sub_category's brands"
      param :sub_category_id, String, desc: 'Filter brands with sub_category_id', required: false
      param :q, String, desc: 'Search by query', required: false
      def brands
        brands = Brand.by_sub_categories_and_search([params[:sub_category_id]], params[:q])
        render_success(SubCategoryBlueprint.render_as_json(brands), status: :ok, message: 'Success')
      end

      private

      def sub_category_params
        params.require(:sub_category).permit(:id, :name, :slug, :category_id, :is_active)
      end
    end
  end
end
