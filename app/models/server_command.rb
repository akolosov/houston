class ServerCommand < ActiveRecord::Base
  resourcify

  belongs_to :server
  belongs_to :command

  attr_accessible :server_id, :command_id, :server, :command, :params

  validates :server, :presence => true
  validates :command, :presence => true

end
