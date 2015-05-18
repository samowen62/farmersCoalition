Rails.application.routes.draw do

  resources :users do
    resources :profiles do
      resources :markets
    end
  end

  get 'profile/index'
  root 'sessions#login'
  #root :to => 'sessions#login'
  get "signup", :to => "users#new"
  get "login", :to => "sessions#login"
  get "logout", :to => "sessions#logout"
  get "display", :to => "users#display"
  get "show", :to => "users#show"
  get "home", :to => "users#home"

  post "login_attempt", :to => "sessions#login_attempt"
  post "post_info", :to => "profile#create"
  post "post_market", :to => "markets#create"
  post "post_managements", :to => "profile#create_man"
  post "post_accessibilities", :to => "profile#create_access"
  post "post_communities", :to => "profile#create_communities"
  post "post_metrics", :to => "profile#create_metrics"
  post "post_visitor_survey", :to => "profile#update_visitor_survey"
  post "post_sales_slip", :to => "profile#update_sales_slip"
  post "post_visitor_count", :to => "profile#update_visitor_count"

  get "user_metrics", :to => "users#metrics"
  get "user_instruments", :to => "users#instruments"
  get "visitor_survey", :to => "users#visitor_survey"
  get "sales_slip", :to => "users#sales_slip"
  get "visitor_count", :to => "users#visitor_count"


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
