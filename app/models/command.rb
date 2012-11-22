# encoding: utf-8
class Command < ActiveRecord::Base
  audit(:create)  { |model, user, action| "Команда \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Команда \"#{model.name}\" изменена, пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил команду \"#{model.name}\"" }

  resourcify

  attr_accessible :command, :confirm, :description, :name, :params, :server_id

  has_many :server_commands
  has_many :servers, :through => :server_commands

  attr :params, :server_id

  def self.commands_for_problem(problem)
    where("id in (select command_id from server_commands where server_id in (select server_id from server_problems where problem_id = #{problem.id}))")
  end

  def self.command_for_problem(problem)
    where("id in (select command_id from server_commands where server_id in (select server_id from server_problems where problem_id = #{problem.id}))").first
  end

  def self.commands_for_server_and_problem(server, problem)
    where("id in (select command_id from server_commands where server_id = #{server.id}) and id in (select command_id from solutions where id in (select solution_id from problem_solutions where problem_id = #{problem.id}))")
  end

  def self.command_for_server_and_problem(server, problem)
    where("id in (select command_id from server_commands where server_id = #{server.id}) and id in (select command_id from solutions where id in (select solution_id from problem_solutions where problem_id = #{problem.id}))").first
  end

  def self.commands_for_server(server)
    where("id in (select command_id from server_commands where server_id = #{server.id})")
  end

  def self.command_for_server(server)
    where("id in (select command_id from server_commands where server_id = #{server.id})").first
  end

end
