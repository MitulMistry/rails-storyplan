Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => 'users/omniauth_callbacks' } #use custom registrations controller override
  resources :stories do
    resources :chapters, only: :new #nested chapter creation
  end
  resources :chapters
  resources :characters
  resources :genres, only: [:index, :show]
  resources :audiences, only: [:index, :show]
  resources :comments, only: [:create, :edit, :update, :destroy]

  #writer isn't a model, just an alias for devise user to separate logic
  scope '/writers' do
    get 'profile' => 'writers#profile'
    get 'edit_profile' => 'writers#edit_profile'
    patch 'update_profile' => 'writers#update_profile'
    get 'my_stories' => 'writers#my_stories'
  end

  resources :writers, only: [:index, :show] do
    #nested resources
    resources :stories, only: [:index]
    resources :characters, only: [:index]
    resources :chapters, only: [:index]
  end

  root 'pages#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
