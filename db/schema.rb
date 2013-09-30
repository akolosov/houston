# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130930063112) do

  create_table "attaches", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "mime"
    t.integer  "size"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.text     "comment"
    t.datetime "created_at",                     :null => false
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "comment_attaches", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "attach_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comment_attaches", ["attach_id"], :name => "index_comment_attaches_on_attach_id"
  add_index "comment_attaches", ["comment_id"], :name => "index_comment_attaches_on_comment_id"

  create_table "comments", :force => true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"

  create_table "divisions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "document_attaches", :force => true do |t|
    t.integer  "document_id"
    t.integer  "attach_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "document_attaches", ["attach_id"], :name => "index_document_attaches_on_attach_id"
  add_index "document_attaches", ["document_id"], :name => "index_document_attaches_on_document_id"

  create_table "document_comments", :force => true do |t|
    t.integer  "document_id"
    t.integer  "comment_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "document_comments", ["comment_id"], :name => "index_document_comments_on_comment_id"
  add_index "document_comments", ["document_id"], :name => "index_document_comments_on_document_id"

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "incedent_actions", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "status_id"
    t.integer  "worker_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_actions", ["incedent_id"], :name => "index_incedent_actions_on_incedent_id"
  add_index "incedent_actions", ["status_id"], :name => "index_incedent_actions_on_status_id"
  add_index "incedent_actions", ["worker_id"], :name => "index_incedent_actions_on_worker_id"

  create_table "incedent_attaches", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "attach_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_attaches", ["attach_id"], :name => "index_incedent_attaches_on_attach_id"
  add_index "incedent_attaches", ["incedent_id"], :name => "index_incedent_attaches_on_incedent_id"

  create_table "incedent_comments", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "comment_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_comments", ["comment_id"], :name => "index_incedent_comments_on_comment_id"
  add_index "incedent_comments", ["incedent_id"], :name => "index_incedent_comments_on_incedent_id"

  create_table "incedent_observers", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_observers", ["incedent_id"], :name => "index_incedent_observers_on_incedent_id"
  add_index "incedent_observers", ["user_id"], :name => "index_incedent_observers_on_user_id"

  create_table "incedent_reviewers", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "user_id"
    t.datetime "reviewed_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_reviewers", ["incedent_id"], :name => "index_incedent_reviewers_on_incedent_id"
  add_index "incedent_reviewers", ["user_id"], :name => "index_incedent_reviewers_on_user_id"

  create_table "incedent_tags", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "incedent_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_tags", ["incedent_id"], :name => "index_incedent_tags_on_incedent_id"
  add_index "incedent_tags", ["tag_id"], :name => "index_incedent_tags_on_tag_id"

  create_table "incedent_workers", :force => true do |t|
    t.integer  "incedent_id"
    t.integer  "user_id"
    t.integer  "status_id"
    t.datetime "finish_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "incedent_workers", ["incedent_id"], :name => "index_incedent_workers_on_incedent_id"
  add_index "incedent_workers", ["status_id"], :name => "index_incedent_workers_on_status_id"
  add_index "incedent_workers", ["user_id"], :name => "index_incedent_workers_on_user_id"

  create_table "incedents", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "initiator_id"
    t.integer  "status_id"
    t.integer  "priority_id"
    t.integer  "type_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "closed",           :default => false
    t.integer  "server_id"
    t.integer  "operator_id"
    t.datetime "finish_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "service_class_id"
    t.string   "state"
  end

  add_index "incedents", ["initiator_id"], :name => "index_incedents_on_initiator_id"
  add_index "incedents", ["priority_id"], :name => "index_incedents_on_priority_id"
  add_index "incedents", ["status_id"], :name => "index_incedents_on_status_id"
  add_index "incedents", ["type_id"], :name => "index_incedents_on_type_id"

  create_table "priorities", :force => true do |t|
    t.string "name"
  end

  create_table "problem_solutions", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "solution_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "problem_solutions", ["problem_id"], :name => "index_problem_solutions_on_problem_id"
  add_index "problem_solutions", ["solution_id"], :name => "index_problem_solutions_on_solution_id"

  create_table "problem_tags", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "problem_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "problem_tags", ["problem_id"], :name => "index_problem_tags_on_problem_id"
  add_index "problem_tags", ["tag_id"], :name => "index_problem_tags_on_tag_id"

  create_table "problems", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "server_attaches", :force => true do |t|
    t.integer  "server_id"
    t.integer  "attach_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "server_attaches", ["attach_id"], :name => "index_server_attaches_on_attach_id"
  add_index "server_attaches", ["server_id"], :name => "index_server_attaches_on_server_id"

  create_table "server_categories", :force => true do |t|
    t.integer  "server_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "server_categories", ["category_id"], :name => "index_server_categories_on_category_id"
  add_index "server_categories", ["server_id"], :name => "index_server_categories_on_server_id"

  create_table "server_problems", :force => true do |t|
    t.integer  "server_id"
    t.integer  "problem_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "server_problems", ["problem_id"], :name => "index_server_problems_on_problem_id"
  add_index "server_problems", ["server_id"], :name => "index_server_problems_on_server_id"

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.string   "address"
    t.string   "username"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "port"
  end

  create_table "service_classes", :force => true do |t|
    t.integer  "service_id"
    t.integer  "type_id"
    t.integer  "priority_id"
    t.integer  "reaction_hours"
    t.boolean  "autoclose"
    t.integer  "autoclose_hours"
    t.integer  "escalation_hours"
    t.integer  "performance_hours"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "is_default",        :default => false
    t.boolean  "review",            :default => false
    t.integer  "review_hours"
  end

  add_index "service_classes", ["priority_id"], :name => "index_service_classes_on_priority_id"
  add_index "service_classes", ["service_id"], :name => "index_service_classes_on_service_id"
  add_index "service_classes", ["type_id"], :name => "index_service_classes_on_type_id"

  create_table "services", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "division_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "solutions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string "name"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                          :null => false
    t.string   "email",                                             :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "activation_state"
    t.string   "activation_code"
    t.datetime "activation_code_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.integer  "failed_logins_count",             :default => 0
    t.datetime "lock_expires_at"
    t.string   "session"
    t.string   "realname"
    t.boolean  "active",                          :default => true
    t.string   "jabber"
    t.string   "last_login_from_ip_address"
    t.boolean  "first_login",                     :default => true
    t.integer  "division_id"
  end

  add_index "users", ["activation_code"], :name => "index_users_on_activation_code"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
