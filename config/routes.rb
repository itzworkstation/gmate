Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      constraints format: :json do
        resources :accounts
        resources :categories
        resources :sub_categories

        resources :stores do
          member do
            post :add_product
            get :products
          end
        end

      end
    end
  end
end
