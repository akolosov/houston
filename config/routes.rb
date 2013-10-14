Houston::Application.routes.draw do

  root to: 'welcome#index'

  get 'search/index'

  get 'audit/index', as: :audit

  get 'attaches/index', as: :files

  get 'incedents/archive', as: :archive

  get 'incedents/observe', as: :observe

  get 'incedents/onreview', as: :onreview

  resources :search

  resources :audit, only: :index

  resources :servers, except: :create

  resources :server_problems, except: :show

  resources :problems, except: :show

  resources :solutions, except: :show

  resources :problem_solutions, except: :show

  resources :documents, except: :create

  resources :tags, except: :show

  resources :divisions, except: :show

  resources :incedents, except: :create do
    collection do
      post :rebuild
    end
  end

  resources :attaches, only: :index

  resources :categories, except: :show

  resources :services do
    collection do
      post :rebuild
    end
  end

  resources :service_classes, except: [:show, :index ]

  resources :welcome

  resources :users

  resources :user_sessions

  match 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', as: :logout
  match 'first_login' => 'users#first_login', as: :first_login

  match 'users/:id/activate' => 'users#activate', as: :activate_user
  match 'users/:id/deactivate' => 'users#deactivate', as: :deactivate_user
  match 'users/:id/password' => 'users#update_password', as: :update_password
  match 'users/:id/settings' => 'users#user_settings', as: :user_settings
  match 'users/:id/setup' => 'users#setup', as: :user_setup
  match 'users/:id/reset' => 'users#reset', as: :reset_user
  match 'users/by_division/:division_id' => 'users#index', as: :users_by_division

  match 'service/:id/add' => 'services#new', as: :add_child_service

  match 'service/:service_id/class/:id' => 'service_classes#edit', as: :edit_service_class
  match 'service/:service_id/add_class' => 'service_classes#new', as: :new_service_class
  match 'service/:service_id/create' => 'service_classes#create', as: :create_service_class
  match 'service/:service_id/class/:id/delete' => 'service_classes#destroy', as: :delete_service_class
  match 'service/:service_id/class/:id/update' => 'service_classes#update', as: :update_service_class


  match 'server/:server_id/problems' => 'server_problems#index', as: :problems_by_server
  match 'server/:server_id/add_problem' => 'server_problems#new', as: :problem_for_server
  match 'server/:server_id/edit_problem/:id' => 'server_problems#edit', as: :edit_problem_for_server
  match 'server/:server_id/problem/:problem_id/solutions' => 'problem_solutions#index', as: :solutions_for_problem_by_server
  match 'server/add' => 'servers#add', as: :add_server
  match 'server/by_category/:category_id(.:format)' => 'servers#index', as: :servers_by_category

  match 'problem/:problem_id/solutions' => 'problem_solutions#index', as: :solutions_by_problem
  match 'problem/:problem_id/add_solution' => 'problem_solutions#new', as: :solution_for_problem
  match 'problem/:problem_id/edit_solution/:id' => 'problem_solutions#edit', as: :edit_solution_for_problem
  match 'problems/by_tag/:tag_id' => 'problems#index', as: :problems_by_tag
  match 'problems/by_solution/:solution_id' => 'problems#index', as: :problems_by_solution

# incedents filter
  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_type_and_user_and_server
  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_type_and_server

  match 'incedents/by_status/:status_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_type_and_user_and_server
  match 'incedents/by_status/:status_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_type_and_server

  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_user_and_server
  match 'incedents/by_status/:status_id/and_priority/:priority_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_priority_and_server

  match 'incedents/by_priority/:priority_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_type_and_user_and_server
  match 'incedents/by_priority/:priority_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_type_and_server

  match 'incedents/by_status/:status_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_user_and_server
  match 'incedents/by_status/:status_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_status_and_server

  match 'incedents/by_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_type_and_user_and_server
  match 'incedents/by_type/:type_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_type_and_server

  match 'incedents/by_priority/:priority_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_user_and_server
  match 'incedents/by_priority/:priority_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_priority_and_server

  match 'incedents/by_user/:user_id/and_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_user_and_server

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
  match 'incedents/by_parent/:parent_id(.:format)' => 'incedents#index', as: :incedents_by_parent
  match 'incedents/by_server/:server_id(.:format)' => 'incedents#index', as: :incedents_by_server

# incedents archive filter
  match 'incedents/archive/by_status/:status_id/and_priority/:priority_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_priority_and_type_and_user_and_server
  match 'incedents/archive/by_status/:status_id/and_priority/:priority_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_priority_and_type_and_server

  match 'incedents/archive/by_status/:status_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_type_and_user_and_server
  match 'incedents/archive/by_status/:status_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_type_and_server

  match 'incedents/archive/by_status/:status_id/and_priority/:priority_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_priority_and_user_and_server
  match 'incedents/archive/by_status/:status_id/and_priority/:priority_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_priority_and_server

  match 'incedents/archive/by_priority/:priority_id/and_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_type_and_user_and_server
  match 'incedents/archive/by_priority/:priority_id/and_type/:type_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_type_and_server

  match 'incedents/archive/by_status/:status_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_user_and_server
  match 'incedents/archive/by_status/:status_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_status_and_server

  match 'incedents/archive/by_type/:type_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_type_and_user_and_server
  match 'incedents/archive/by_type/:type_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_type_and_server

  match 'incedents/archive/by_priority/:priority_id/and_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_user_and_server
  match 'incedents/archive/by_priority/:priority_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_server

  match 'incedents/archive/by_user/:user_id/and_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_user_and_server

  match 'incedents/archive/by_priority/:priority_id/and_type/:type_id/and_user/:user_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_type_and_user
  match 'incedents/archive/by_priority/:priority_id/and_type/:type_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_type

  match 'incedents/archive/by_type/:type_id/and_user/:user_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_type_and_user
  match 'incedents/archive/by_type/:type_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_type

  match 'incedents/archive/by_priority/:priority_id/and_user/:user_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority_and_user
  match 'incedents/archive/by_priority/:priority_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_priority

  match 'incedents/archive/by_user/:user_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_user
  match 'incedents/archive/by_tag/:tag_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_tag
  match 'incedents/archive/by_parent/:parent_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_parent
  match 'incedents/archive/by_server/:server_id(.:format)' => 'incedents#archive', as: :incedents_archive_by_server

  match 'incedents/archive' => 'incedents#archive', as: :incedents_archive
  match 'incedents/observe' => 'incedents#observe', as: :incedents_observe
  match 'incedents/onreview' => 'incedents#onreview', as: :incedents_onreview

  match 'incedent/add' => 'incedents#add', as: :add_incedent
  match 'incedent/by_class/:service_class_id/add' => 'incedents#new', as: :add_incedent_by_class

  match 'incedent/:id/unwatch' => 'incedents#unwatch', as: :unwatch_incedent
  match 'incedent/:id/watch' => 'incedents#watch', as: :watch_incedent
  match 'incedent/:id/play' => 'incedents#play', as: :play_incedent
  match 'incedent/:id/replay' => 'incedents#replay', as: :replay_incedent
  match 'incedent/:id/work' => 'incedents#work', as: :work_incedent
  match 'incedent/:id/pause' => 'incedents#pause', as: :pause_incedent
  match 'incedent/:id/stop' => 'incedents#stop', as: :stop_incedent
  match 'incedent/:id/reject' => 'incedents#reject', as: :reject_incedent
  match 'incedent/:id/review' => 'incedents#review', as: :review_incedent
  match 'incedent/:id/solve' => 'incedents#solve', as: :solve_incedent
  match 'incedent/:id/close' => 'incedents#close', as: :close_incedent
  match 'incedent/:id/comments' => 'incedents#show', as: :incedent_comments
  match 'incedent/:incedent_id/comment' => 'incedents#comment', as: :add_incedent_comment
  match 'incedent/:incedent_id/comment/:comment_id/delete' => 'incedents#delete_comment', as: :delete_incedent_comment

  match 'document/:id/move' => 'documents#move', as: :move_document_to_solution
  match 'document/:id/comments' => 'documents#show', as: :document_comments
  match 'document/:document_id/comment' => 'documents#comment', as: :add_document_comment
  match 'document/:document_id/comment/:comment_id/delete' => 'documents#delete_comment', as: :delete_document_comment
  match 'document/add' => 'documents#add', as: :add_document

end
