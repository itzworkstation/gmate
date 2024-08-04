# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < BaseController
      def_param_group :category do
        param :category, Hash, desc: 'category parameters', required: true do
          param :name, String, desc: 'Category name', required: true
          param :slug, String, desc: 'Category slug', required: true
          param :is_active, :boolean, desc: 'Category is active or not. Default is active',
                                      required: false
        end
      end

      api :GET, '/categories', 'Get a list of categories'
      def index
        categories = Category.all
        render json: CategoryBlueprint.render(categories, root: :categories)
      end

      api :POST, '/categories', 'Create an account'
      param_group :category
      def create
        category = Category.new(category_params)
        return render json: CategoryBlueprint.render(category) if category.save

        render json: { error: category.errors.full_messages }, status: :unprocessable_entity
      end

      private

      def category_params
        params.require(:category).permit(:id, :name, :slug, :is_active)
      end
    end
  end
end
