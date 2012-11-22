# encoding: utf-8
class Role < ActiveRecord::Base
  audit(:create) { |model, user, action| "Роль \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Роль \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил роль \"#{model.name}\"" }

  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource, :polymorphic => true

  scopify
end
