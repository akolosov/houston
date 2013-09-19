class ServiceClass < ActiveRecord::Base
  resourcify

  belongs_to :service
  belongs_to :type
  belongs_to :priority

  has_many :incedents

  attr_accessible :priority_id, :type_id, :service_id, :autoclose, :autoclose_hours, :escalation_hours, :performance_hours, :reaction_hours
end
