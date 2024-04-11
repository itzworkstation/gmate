module Api
  module V1
    class StoresController < BaseController
      include ProductConcern
      before_action :authorize_request
      def_param_group :product do
        param :product, Hash, desc: '', required: true do
          param :name, String, desc: 'It can be string or product id', required: true
          param :measurement, Integer, desc: 'Measurement', required: false
          param :measurement_unit, Integer, desc: 'Measurement unit', required: false
          param :brand_id, Integer, desc: 'Beand for a product', required: false
          param :dtf, Integer, desc: 'Days to finish it', required: false
          param :is_pack, :boolean, desc: 'It will be considered as one unit. Default: true', required: false
          param :sub_category_id, Integer, desc: 'It is subcategory'
        end
      end

      api :GET, '/stores', 'Get all the stores'
      param :account_id, String, desc: 'Account id', required: false
      def index
        stores = @current_account.stores
        render json: StoreBlueprint.render(stores)
      end

      param :store, Hash, desc: 'Store params', required: true do
        param :name, String, desc: 'Store name', required: true
        param :account_id, Integer, desc: 'Account id', required: true
      end
      api :POST, '/stores', 'Create a store'
      def create
        store = Store.new(store_params)
        if store.save
          render json: StoreBlueprint.render(store)
        else
          render json: {error: store.errors.full_messages.join(',')}, status: :unprocessable_entity
        end
      end

      param :store, Hash, desc: 'Store params', required: true do
        param :name, String, desc: 'Store name', required: true
      end
      api :PATCH, '/stores/{id}', 'Update a store'
      def update
        store = Store.find(params[:id])
        if store.update(store_params)
          render json: StoreBlueprint.render(store)
        else
          render json: {error: store.errors.full_messages.join(',')}, status: :unprocessable_entity
        end
      end

      api :POST, '/stores/:id/add_product', 'Add a product to store'
      param_group :product
      def add_product
        store_product = StoreProduct.new(product_id: set_product_id, store_id: params[:id])
        if store_product.save
          render json: {message: 'Product added successfully'}, status: :ok
        else
          logger.error { "Could not save because "+ store_product.errors.full_messages[0] }
          render json: {error: 'Could not add product in store'}, status: :unprocessable_entity
        end
      end

      api :GET, '/stores/:id/products', 'Get all store products'
      param :offset, Integer, required: false
      param :limit, Integer, required: false
      def products
        Store.find params[:id]
        store_products= StoreProduct.includes(store: [], product: [:sub_category])
        .where(store_id: params[:id])
        .offset(0)
        .limit(10)
        .group_by { |store_product| store_product.product.sub_category&.name }
        
        response = store_products.map {|k,v| ["#{k}", StoreProductBlueprint.render_as_json(v)] }
        render json: response.to_h
      end

      private

      def store_params
        params.require(:store).permit(:id, :name, :account_id)
      end

      def product_params
        params.require(:product).permit(:id, :measurement, :measurement_unit, :brand_id, :dtf, :is_pack)
      end

      def set_product_id
        name = params[:product][:name]
        name.to_i > 0 ? name : create_subcategory_product(name: name, sub_category_id: params[:product][:sub_category_id])&.id
      end
      
    end
  end
end
