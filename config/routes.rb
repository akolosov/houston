Houston::Application.routes.draw do

  root to: 'welcome#index'

  get "search/index"

  get "audit/index", as: :audit

  get 'incedents/archive', as: :archive

  resources :search

  resources :audit

  resources :servers, except: :show

  resources :server_problems, except: :show

  resources :problems, except: :show

  resources :solutions, except: :show

  resources :problem_solutions, except: :show

  resources :documents

  resources :tags, except: :show

  resources :incedents

  resources :attaches

  resources :welcome do
    member do
      get 'denied'
    end
  end

  resources :users

  resources :user_sessions

  match 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', as: :logout

  match 'server/:server_id/problems' => 'server_problems#index', as: :problems_by_server
  match 'server/:server_id/add_problem' => 'server_problems#new', as: :problem_for_server
  match 'server/:server_id/edit_problem/:id' => 'server_problems#edit', as: :edit_problem_for_server
  match 'server/:server_id/problem/:problem_id/solutions' => 'problem_solutions#index', as: :solutions_for_problem_by_server

  match 'problem/:problem_id/solutions' => 'problem_solutions#index', as: :solutions_by_problem
  match 'problem/:problem_id/add_solution' => 'problem_solutions#new', as: :solution_for_problem
  match 'problem/:problem_id/edit_solution/:id' => 'problem_solutions#edit', as: :edit_solution_for_problem
  match 'problems/by_tag/:tag_id' => 'problems#index', as: :problems_by_tag

  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_type/:type_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_type_and_user
  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_type/:type_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_type

  match 'incedents/by_status/:status_id/and_type/:type_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_type_and_user
  match 'incedents/by_status/:status_id/and_type/:type_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_type

  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_user
  match 'incedents/by_status/:status_id/and_priority/:priority_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority

  match 'incedents/by_priority/:priority_id/and_type/:type_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_type_and_user
  match 'incedents/by_priority/:priority_id/and_type/:type_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_type

  match 'incedents/by_status/:status_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_user
  match 'incedents/by_status/:status_id(.:format)' => 'incedents#index', as: :incedents_by_status

  match 'incedents/by_type/:type_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_type_and_user
  match 'incedents/by_type/:type_id(.:format)' => 'incedents#index', as: :incedents_by_type

  match 'incedents/by_priority/:priority_id/and_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_user
  match 'incedents/by_priority/:priority_id(.:format)' => 'incedents#index', as: :incedents_by_priority

  match 'incedents/by_user/:user_id(.:format)' => 'incedents#index', as: :incedents_by_user
  match 'incedents/by_tag/:tag_id(.:format)' => 'incedents#index', as: :incedents_by_tag
  
  match 'incedents/archive' => 'incedents#archive', as: :incedents_archive

  match 'incedent/:id/play' => 'incedents#play', as: :play_incedent
  match 'incedent/:id/replay' => 'incedents#replay', as: :replay_incedent
  match 'incedent/:id/pause' => 'incedents#pause', as: :pause_incedent
  match 'incedent/:id/stop' => 'incedents#stop', as: :stop_incedent
  match 'incedent/:id/reject' => 'incedents#reject', as: :reject_incedent
  match 'incedent/:id/solve' => 'incedents#solve', as: :solve_incedent
  match 'incedent/:id/close' => 'incedents#close', as: :close_incedent
  match 'incedent/:id/comments' => 'incedents#show', as: :incedent_comments
  match 'incedent/:incedent_id/comment' => 'incedents#comment', as: :add_incedent_comment

  match 'document/:id/move' => 'documents#move', as: :move_document_to_solution
  match 'document/:id/comments' => 'documents#show', as: :document_comments
  match 'document/:document_id/comment' => 'documents#comment', as: :add_document_comment

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # This route can be invoked with purchase_url(id: product.id)

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
  #       get 'recent', on: :collection
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
  # root to: "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
