class ServerCommand < ActiveRecord::Base
  resourcify

  belongs_to :server
  belongs_to :command

  attr_accessible :server_id, :command_id, :server, :command, :params

  validates :server, :presence => true
  validates :command, :presence => true

  def self.commands_for_server(server)
    where("server_id = #{server.id}")
  end

  def self.command_for_server(command, server)
    where("server_id = #{server.id} and command_id = #{command.id}").first
  end

  def self.many_commands(command)
    where("command_id = #{command.id}")
  end

  def self.one_command(command)
    where("command_id = #{command.id}").first
  end

end
