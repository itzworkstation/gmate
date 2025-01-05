# frozen_string_literal: true

module Api
  module V1
    module Admin
      class BrandsController < BaseController
        api :POST, '/v1/brands', 'Get all brands'
        def index
          brands = Brand.all
          render_success(BrandBlueprint.render_as_json(brands), status: :ok, message: 'Fetched successfully')
        end

        def create
          brand = Brand.new(name: params[:brand][:name])
          brand.save
          render_success(BrandBlueprint.render_as_json(brand), status: :ok, message: 'Fetched successfully')
        end

        def destroy
          brand = Brand.find(params[:id])
          if brand.destroy
            render_success(BrandBlueprint.render_as_json(brand), status: :ok, message: 'Fetched successfully')
          end
          rescue
            render_error("sdsdsddsd", status: :unprocessable_entity)
          
        end
      end
    end
  end
end
