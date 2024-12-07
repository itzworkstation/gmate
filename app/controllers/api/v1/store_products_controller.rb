# frozen_string_literal: true

module Api
  module V1
    class StoreProductsController < BaseController
      before_action :authorize_request
      before_action :find_store, except: %i[barcode_product]

      def_param_group :product do
        param :product, Hash, desc: '', required: true do
          param :days_to_consume, Integer, desc: 'Days to consume it', required: false
          param :start_to_consume, String, desc: 'The date in YYYY-MM-DD format', required: false
          param :state, String, desc: "State of the prodct", required: false
        end
      end

      api :GET, '/v1/stores/:store_id/store_products/:id', 'Get store product detail'
      def show
        render_success({product: StoreProductBlueprint.render_as_json(@store_product), states: @store_product.all_next_states.map(&:upcase)}, status: :ok, message: 'Success')
      end

      api :GET, '/v1/stores/:store_id/product', 'Get store product detail by barcode'
      def barcode_product
        store_product =  StoreProduct.order("RANDOM()").first
        if params[:barcode].present?
          render_success({product: StoreProductBlueprint.render_as_json(store_product)}, status: :ok, message: 'Success')
        else
          render_error("Barcode is missing", status: :unprocessable_entity)
        end
      end

      api :PUT, '/v1/stores/:store_id/store_products/:id', 'Update store product detail'
      param_group :product
      def update
        attributes = product_params
        attributes[:state] = StoreProduct.states.fetch(attributes[:state].downcase, 0)
        if @store_product.update(attributes)
          render_success(StoreProductBlueprint.render_as_json(@store_product), status: :ok, message: 'Success')
        else
          render_error(@store_product.errors.full_messages.join(','), status: :unprocessable_entity)
        end
      end

      private
      def find_store
        store = Store.where(account_id: @current_account.id, id: params[:store_id]).first
        if store.nil?
          return render json: { error: 'Invalid store' }, status: :unprocessable_entity 
        end
        @store_product = store.store_products.includes(:brand, product: [sub_category: :category]).find(params[:id])
      end

      def product_params
        params.require(:product).permit(:id, :days_to_consume, :start_to_consume, :state)
      end 
    end
  end
end
