class ServiceClass < ActiveRecord::Base
  resourcify

  belongs_to :service
  belongs_to :type
  belongs_to :priority

  has_one :incedent

  scope :default_class, where('is_default = ?', true)

  scope :by_service, lambda { |service| where("service_id = ?", service) unless service.nil? }

  validates_presence_of [:priority_id, :type_id, :autoclose_hours, :escalation_hours, :performance_hours, :reaction_hours, :review_hours]

  validates_uniqueness_of :service_id, scope: [:type_id, :priority_id], message: 'Класс обслуживания с таким типом и приоритетом уже существует для данного сервиса!'

  validates_uniqueness_of :is_default, scope: :service_id, unless: lambda { |cl| !cl.is_default }, message: 'Класс обслуживания по умолчанию уже задан для данного сервиса!'

  attr_accessible :priority_id, :type_id, :service_id, :autoclose, :autoclose_hours, :escalation_hours, :performance_hours, :reaction_hours, :review_hours, :is_default, :review
end
