class IncedentAction < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :status
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id'

  attr_accessible :incedent, :status, :worker, :status_id
end
