# encoding: utf-8
class Server < ActiveRecord::Base
  audit(:create) { |model, user, action| "Сервер \"#{model.name}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Сервер \"#{model.name}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил сервер \"#{model.name}\", пользователь: #{user.display_name}" }

  resourcify

  before_save :default_values

  attr_accessible :address, :description, :location, :name, :username, :port, :categories, :category_ids, :attaches_attributes

  validates :name, :description, presence: true

  has_many :server_problems, dependent: :destroy
  has_many :problems, through: :server_problems, dependent: :destroy

  has_many :server_categories, dependent: :destroy
  has_many :categories, through: :server_categories, dependent: :destroy

  has_many :server_attaches, dependent: :destroy
  has_many :attaches, through: :server_attaches, dependent: :destroy

  accepts_nested_attributes_for :attaches, allow_destroy: true

  def default_values
    self.port ||= '22'
  end

  def self.servers_by_category(category)
    where("id in (select server_id from server_categories where category_id = #{category.id})")
  end

  def self.search(query)
    where("name like '%#{query}%' or description like '%#{query}%'")
  end

end
