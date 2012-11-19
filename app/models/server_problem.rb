class ServerProblem < ActiveRecord::Base
  belongs_to :server
  belongs_to :problem
end
