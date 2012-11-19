class Server < ActiveRecord::Base
  resourcify

  attr_accessible :address, :description, :location, :name, :username

  has_many :server_commands
  has_many :commands, :through => :server_commands

  has_many :server_problems
  has_many :problems, :through => :server_problems
end
