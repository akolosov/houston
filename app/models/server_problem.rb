class ServerProblem < ActiveRecord::Base
  belongs_to :server
  belongs_to :problem

  validates :server, :presence => true
  validates :problem, :presence => true
end
