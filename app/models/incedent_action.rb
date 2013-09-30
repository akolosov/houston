class IncedentAction < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :status
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id'

  attr_accessible :incedent, :status, :worker, :status_id

  before_save :default_values

  def default_values
    self.status_id ||= Houston::Application.config.incedent_created
  end
end
