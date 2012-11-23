Houston::Application.routes.draw do

  root :to => 'welcome#index'

  get "search/index"

  get "audit/index", :as => :audit

  resources :search

  resources :audit

  resources :servers

  resources :server_problems

  resources :problems

  resources :solutions

  resources :problem_solutions

  resources :welcome do
    member do
      get 'denied'
    end
  end

  resources :users

  resources :user_sessions

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'server/:server_id/problems' => 'server_problems#index', :as => :problems_by_server
  match 'server/:server_id/add_problem' => 'server_problems#new', :as => :problem_for_server
  match 'server/:server_id/edit_problem/:id' => 'server_problems#edit', :as => :edit_problem_for_server
  match 'server/:server_id/problem/:problem_id/solutions' => 'problem_solutions#index', :as => :solutions_for_problem_by_server

  match 'problem/:problem_id/solutions' => 'problem_solutions#index', :as => :solutions_by_problem
  match 'problem/:problem_id/add_solution' => 'problem_solutions#new', :as => :solution_for_problem
  match 'problem/:problem_id/edit_solution/:id' => 'problem_solutions#edit', :as => :edit_solution_for_problem

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
