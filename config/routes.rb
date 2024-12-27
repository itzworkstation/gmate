# frozen_string_literal: true
require 'sidekiq/web'
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
            get :info
          end
        end
        resources :categories
        resources :sub_categories

        resources :stores do
          member do
            post :add_product
            get :products
            get :invoices, :notifications
            post :upload_invoice
          end
          resources :store_products
        end
        get 'barcode_product', to: "store_products#barcode_product"
        get 'brands', to: "sub_categories#brands"
        resources :reports, only: [:index]
      end
    end
  end
  # Sidekiq web interface (protected by HTTP basic auth in production)
  mount Sidekiq::Web => '/sidekiq'
end
