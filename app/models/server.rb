class Server < ActiveRecord::Base
  resourcify

  attr_accessible :address, :description, :location, :name, :username

  has_many :server_commands
  has_many :commands, :through => :server_commands

  has_many :server_problems
  has_many :problems, :through => :server_problems

  def self.servers_for_command(command)
    where("id in (select server_id from server_commands where command_id = #{command.id})")
  end

  def self.servers_for_problem(problem)
    where("id in (select server_id from server_problems where problem_id = #{problem.id})")
  end
end
