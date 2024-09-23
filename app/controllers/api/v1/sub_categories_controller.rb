# frozen_string_literal: true

module Api
  module V1
    class SubCategoriesController < BaseController
      def_param_group :sub_category do
        param :sub_category, Hash, desc: 'sub_category parameters', required: true do
          param :name, String, desc: 'sub_category name', required: true
          param :slug, String, desc: 'sub_category slug', required: true
          param :category_id, Integer, desc: 'category_id', required: true
          param :is_active, :boolean, desc: 'sub_category is active or not. Default is active',
                                      required: false
        end
      end

      api :GET, '/v1/sub_categories', 'Get a list of sub_category'
      def index
        sub_categories = SubCategory.all
        render json: SubCategoryBlueprint.render(sub_categories, root: :sub_categories)
      end

      api :POST, '/v1/sub_categories', 'Create an account'
      param_group :sub_category
      def create
        category = SubCategory.new(sub_category_params)
        return render json: CategoryBlueprint.render(category) if category.save

        render json: { error: category.errors.full_messages }, status: :unprocessable_entity
      end

      private

      def sub_category_params
        params.require(:sub_category).permit(:id, :name, :slug, :category_id, :is_active)
      end
    end
  end
end
