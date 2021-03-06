class Service < ActiveRecord::Base
  acts_as_nested_set

  include TheSortableTree::Scopes

  audit(:create) { |model, user, action| "Сервис \"#{model.name}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Сервис \"#{model.name}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил сервис \"#{model.name}\"" }

  resourcify

  after_create :classes_by_default

  attr_accessible :description, :name, :parent_id, :division, :division_id

  validates :name, :description, presence: true

  has_many :service_classes

  belongs_to :parent,
             :class_name => "Service",
             :foreign_key => "parent_id"

  has_many :childs,
           :class_name => "Service",
           :foreign_key => "parent_id",
           :order => "name",
           :dependent => :delete_all

  belongs_to :division

  scope :by_division, lambda { |division| where("division_id = ?", division) unless division.nil? }

  def classes_by_default
    unless self.service_classes.present?
      unless self.parent.present?
        Type.all.each do |type|
          Priority.all.each do |prio|
            ServiceClass.create(priority_id: prio.id, type_id: type.id, service_id: self.id, autoclose: true,
                                autoclose_hours: Houston::Application.config.class_of_service_time[type.id.to_s][prio.id.to_s][1],
                                escalation_hours: Houston::Application.config.class_of_service_time[type.id.to_s][prio.id.to_s][2],
                                performance_hours: Houston::Application.config.class_of_service_time[type.id.to_s][prio.id.to_s][3],
                                reaction_hours: Houston::Application.config.class_of_service_time[type.id.to_s][prio.id.to_s][0],
                                review_hours: Houston::Application.config.class_of_service_time[type.id.to_s][prio.id.to_s][4]).save
          end
        end
      else
        self.parent.service_classes.each do |service_class|
          ServiceClass.create(priority_id: service_class.priority_id, type_id: service_class.type_id, service_id: self.id, autoclose: service_class.autoclose,
                              autoclose_hours: service_class.autoclose_hours, escalation_hours: service_class.escalation_hours,
                              performance_hours: service_class.performance_hours, reaction_hours: service_class.reaction_hours, review_hours: service_class.review_hours).save
        end
        self.division = self.parent.division unless self.division.nil?
      end
    end
  end

  def has_parent?
    !self.parent_id.nil?
  end

  def have_childs?
    self.childs.present?
  end

  def parents_count
    count = 0
    if self.has_parent?
      count = 1
      count += self.parent.parents_count
    end
    count
  end

  def self.search(query)
    where("name like '%#{query}%' or description like '%#{query}%'")
  end

end
