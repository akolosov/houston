class ServerCommand < ActiveRecord::Base
  belongs_to :server
  belongs_to :command

  attr_accessible :server_id, :command_id, :params

  validates :server, :presence => true
  validates :command, :presence => true

end
