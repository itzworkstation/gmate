# frozen_string_literal: true

Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "homes#index"
  
  apipie
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      constraints format: :json do
        resources :accounts, only: [:index, :create] do
          collection do
            post :verify_otp
            put :update
          end
        end
        resources :categories
        resources :sub_categories

        resources :stores do
          member do
            post :add_product
            get :products
          end
          resources :store_products
        end
        get 'barcode_product', to: "store_products#barcode_product"
        get 'brands', to: "sub_categories#brands"
        resources :reports, only: [:index]
      end
    end
  end
end
