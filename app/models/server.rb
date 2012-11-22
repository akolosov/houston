# encoding: utf-8
class Server < ActiveRecord::Base
  audit(:create) { |model, user, action| "Сервер \"#{model.name}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Сервер \"#{model.name}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил сервер \"#{model.name}\", пользователь: #{user.display_name}" }

  resourcify

  before_save :default_values

  attr_accessible :address, :description, :location, :name, :username, :port

  has_many :server_commands
  has_many :commands, :through => :server_commands

  has_many :server_problems
  has_many :problems, :through => :server_problems

  def default_values
    self.port ||= '22'
  end

  def self.servers_for_command(command)
    where("id in (select server_id from server_commands where command_id = #{command.id})")
  end

  def self.servers_for_problem(problem)
    where("id in (select server_id from server_problems where problem_id = #{problem.id})")
  end
end
