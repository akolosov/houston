class ServerProblem < ActiveRecord::Base
  resourcify

  belongs_to :server
  belongs_to :problem

  validates :server, :presence => true
  validates :problem, :presence => true
end
