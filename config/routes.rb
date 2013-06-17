LoanedInventory::Application.routes.draw do
  resources :report_entries

  resources :audit_log_entries

  resources :administrators

  resources :inventory_loans do
	collection do
		get 'import'
		post 'upload'
    get 'export'
	end
  end


  resources :loanees do
	collection do
		get 'import'
		post 'upload'
    get 'export'
	end
  end


  resources :inventory_object_versions


  resources :inventory_object_types


  resources :inventory_objects do
	collection do
		get 'import'
		post 'upload'
    get 'export'
    
    get 'autocomplete_tag_name'
	end
  end

	#user authentication
	get "login" => "sessions#new" 
	post "login" => "sessions#create"
	get "logout" => "sessions#destroy"
  
  #point of sale
  get "point_of_sale/create" => "point_of_sale#tag"
  post "point_of_sale/create" => "point_of_sale#tag"

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	root :to => 'welcome#index'


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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
