# encoding: utf-8
class ServerProblem < ActiveRecord::Base
  audit(:create) { |model, user, action| "Проблема \"#{model.problem.name}\" для сервера \"#{model.server.name}\" создана, пользователь: #{user.display_name}" }
  audit(:update) { |model, user, action| "Проблема \"#{model.problem.name}\" для сервера \"#{model.server.name}\" изменена, пользователь: #{user.display_name}" }
  audit(:destroy) { |model, user, action| "#{user.display_name} удалил проблему \"#{model.problem.name}\" для сервера \"#{model.server.name}\" " }

  resourcify

  belongs_to :server
  belongs_to :problem

  validates :server, :presence => true
  validates :problem, :presence => true
end
