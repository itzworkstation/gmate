# frozen_string_literal: true

module Api
  module V1
    class StoresController < BaseController
      PRODUCT_FILTER_OPTIONS = ['Early to finish', 'Available'].freeze
      include ProductConcern
      include Pagination
      before_action :authorize_request
      before_action :find_store, only: [:add_product, :update, :products, :destory]
      def_param_group :product do
        param :product, Hash, desc: '', required: true do
          param :name, String, desc: 'It can be string or product id', required: true
          # param :measurement, Integer, desc: 'Measurement', required: false
          # param :measurement_unit, String, desc: 'Measurement unit', required: false
          # param :brand_id, String, desc: 'Brand for a product', required: false, allow_nil: true
          # param :days_to_consume, Integer, desc: 'Days to consume it', required: false, allow_nil: true
          # param :start_to_consume, String, desc: 'The date in YYYY-MM-DD format', required: false, allow_nil: true
          param :sub_category_id, Integer, desc: 'It is subcategory', required: true
        end
      end

      api :GET, '/v1/stores', 'Get all the stores'
      param :account_id, String, desc: 'Account id', required: false
      def index
        stores = @current_account.stores
        render_success(StoreBlueprint.render_as_json(stores), status: :ok, message: 'Success')
      end

      param :store, Hash, desc: 'Store params', required: true do
        param :name, String, desc: 'Store name', required: true
      end
      api :POST, '/v1/stores', 'Create a store'
      def create
        store = Store.new(store_params.merge!(account_id: @current_account.id))
        if store.save
          render_success(StoreBlueprint.render_as_json(store), status: :ok, message: 'Success')
        else
          render_error(store.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      param :store, Hash, desc: 'Store params', required: true do
        param :name, String, desc: 'Store name', required: true
      end
      api :PATCH, '/v1/stores/{id}', 'Update a store'
      def update
        if @store.update(store_params)
          render_success(StoreBlueprint.render_as_json(@store), status: :ok, message: 'Success')
        else
          render_error(@store.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      api :POST, '/v1/stores/:id/add_product', 'Add a product to store'
      param_group :product
      def add_product
        store_product = StoreProduct.new(sanitized_product_params)
        if store_product.save
          render_success({}, status: :ok, message: 'Product added successfully')
        else
          logger.error { "Could not save because #{store_product.errors.full_messages[0]}" }
          render_error('Could not add product in store', status: :unprocessable_entity)
        end
      end

      api :GET, '/v1/stores/:id/products', 'Get all store products'
      # param :offset, Integer, required: false
      # param :limit, Integer, required: false
      # param :sub_category_id, String, required: false
      # param :q, String, desc: 'search by query', required: false, allow_nil: true
      def products
        store_products = StoreProduct.includes(:product).filtered(@store.id, params[:category_id], params[:q])
                                     .offset(offset)
                                     .limit(limit)
        response = store_products.map { |store_product| StoreProductBlueprint.render_as_json(store_product) }
        render_success({products: response, filters: PRODUCT_FILTER_OPTIONS}, status: :ok, message: 'Success')
      end

      private
      def store_params
        params.require(:store).permit(:id, :name)
      end

      def product_params
        params.require(:product).permit(:id, :name, :measurement, :measurement_unit, :brand_id, :sub_category_id, :days_to_consume, :is_pack, :brand_id, :start_to_consume, :expiry_date, :price)
      end

      def sanitized_product_params
        product_name = product_params[:name]
        brand = product_params[:brand_id]
        product_id = product_name.to_i.positive? ? product_name : create_subcategory_product(name: product_name, sub_category_id: product_params[:sub_category_id])&.id
        attributes =  product_params.except(:sub_category_id, :name)
        attributes[:product_id] =  product_id
        attributes[:store_id] = @store.id
        attributes[:brand_id] = brand.to_i.positive? ? brand.to_i : create_subcategory_brand(name: brand, sub_category_id: product_params[:sub_category_id])
        attributes[:measurement_unit] = StoreProduct.measurement_units.fetch(product_params[:measurement_unit].downcase, 0)
        attributes
      end

      def find_store
        @store = Store.where(account_id: @current_account.id, id: params[:id]).first
        if @store.nil?
          return render json: { error: 'Invalid store' }, status: :unprocessable_entity 
        end
      end
    end
  end
end
