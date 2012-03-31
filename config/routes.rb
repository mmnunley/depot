Depot::Application.routes.draw do
  get 'admin' => 'admin#index', :as => 'admin'


#Here since there is no database model behind it we have to 
#define what the controller does with each action. We have to
#tell it what to do with the "Get" and "Posts". The 3 actions
#below are the 3 actions within the controller.
  controller :sessions do
    get 'login'     => :new
    post 'login'    => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :orders

  resources :line_items do
    put 'decrease', on: :member
    put 'increase', on: :member
  end

  resources :carts

  get "store/index"

  resources :products do
    #This action will respond to HTTP GET requests and will operate
    #on a member of the collection (in other words on an individual
    #product) as opposed to the entire collection itself (which
    #in this case would mean all products)
    get :who_bought, :on => :member
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'store#index', :as => 'store'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
