Rails.application.routes.draw do
  resources :charges
  get 'users/account'
  get 'users/calendar'
  get 'projects/dashboard'
  get 'users/:id/aircraft' => 'users#aircraft'
  get 'users/:id/profile' => 'users#profile'
  get 'sessions/login'
  get 'sessions/logout'
  get 'become_a_pilot' => 'users#become_a_pilot'
  post 'sessions/login_attempt'
  post 'users/new_pilot'
  resources :interactions
  resources :referrals
  resources :media_types
  resources :media
  resources :project_status_types
  resources :project_statuses
  resources :project_types
  resources :projects
  resources :user_types
  resources :users
  get 'main/index'
  get 'signup' => 'users#signup'
  get 'confirm_signup' => 'users#confirm_signup'
  get 'dashboard' => 'main#dashboard'
  get 'main/about'

  get 'contact' => 'main#contact'
  post 'main/create_contact'
  get 'affiliates' => 'main#affiliates'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

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
