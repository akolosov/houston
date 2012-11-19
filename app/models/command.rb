class Command < ActiveRecord::Base
  resourcify

  attr_accessible :command, :confirm, :description, :name, :with_params

  has_many :server_commands
  has_many :servers, :through => :server_commands
end
