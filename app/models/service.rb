class Service < ActiveRecord::Base
  acts_as_nested_set

  include TheSortableTree::Scopes

  audit(:create) { |model, user, action| "Сервис \"#{model.name}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Сервис \"#{model.name}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил сервис \"#{model.name}\"" }

  resourcify

  attr_accessible :description, :name, :parent_id

  validates :name, :description, presence: true

  belongs_to :parent,
             :class_name => "Service",
             :foreign_key => "parent_id"

  has_many :childs,
           :class_name => "Service",
           :foreign_key => "parent_id",
           :order => "name",
           :dependent => :delete_all

  def has_parent?
    !self.parent_id.nil?
  end

  def parents_count
    count = 0
    if self.has_parent?
      count = 1
      count += self.parent.parents_count
    end
    count
  end

end
