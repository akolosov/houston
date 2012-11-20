Houston::Application.routes.draw do

  root :to => 'welcome#index'

  get "search/index"

  resources :commands

  resources :search

  resources :servers

  resources :server_commands

  resources :server_problems

  resources :problems

  resources :solutions

  resources :welcome do
    member do
      get 'denied'
    end
  end

  resources :users

  resources :user_sessions

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'servers/:server_id/commands' => 'server_commands#index', :as => :commands_by_server
  match 'servers/:server_id/problems' => 'server_problems#index', :as => :problems_by_server
  match 'servers/:server_id/add_problem' => 'server_problems#new', :as => :problem_for_server
  match 'servers/:server_id/edit_problem/:id' => 'server_problems#edit', :as => :edit_problem_for_server
  match 'servers/:server_id/add_command' => 'server_commands#new', :as => :command_for_server
  match 'servers/:server_id/edit_command/:id' => 'server_commands#edit', :as => :edit_command_for_server
  match 'servers/:server_id/problems/:problem_id/solutions' => 'solutions#index', :as => :solutions_for_problem_by_server
  match 'servers/:server_id/problems/:problem_id/solutions/:id/run' => 'solutions#run', :as => :run_problem_solution
  match 'servers/:server_id/problems/:id/run' => 'problems#run', :as => :run_problem_solutions_for_server
  match 'servers/:server_id/run/:id' => 'server_commands#run', :as => :run_command_on_server

  match 'commands/:id/run' => 'commands#run', :as => :run_command
  match 'solutions/:id/run' => 'solutions#run', :as => :run_solution
  match 'problems/:problem_id/solutions/:id/run' => 'solutions#run', :as => :run_solution_for_problem
  match 'problems/:id/run' => 'problems#run', :as => :run_problem_solutions

  match 'problems/:problem_id/solutions' => 'solutions#index', :as => :solutions_by_problem
  match 'problems/:problem_id/add_solution' => 'solutions#new', :as => :solution_for_problem

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
