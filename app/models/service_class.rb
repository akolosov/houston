class ServiceClass < ActiveRecord::Base
  resourcify

  belongs_to :service
  belongs_to :type
  belongs_to :priority

  has_many :incedents

  validates_presence_of [:priority_id, :type_id, :autoclose_hours, :escalation_hours, :performance_hours, :reaction_hours]

  validates_uniqueness_of :service_id, scope: [:type_id, :priority_id], message: 'Класс обслуживания с таким типом и приоритетом уже существует для данного сервиса'

  attr_accessible :priority_id, :type_id, :service_id, :autoclose, :autoclose_hours, :escalation_hours, :performance_hours, :reaction_hours
end
