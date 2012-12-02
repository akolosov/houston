# encoding: utf-8
class Server < ActiveRecord::Base
  audit(:create) { |model, user, action| "Сервер \"#{model.name}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Сервер \"#{model.name}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил сервер \"#{model.name}\", пользователь: #{user.display_name}" }

  resourcify

  before_save :default_values

  attr_accessible :address, :description, :location, :name, :username, :port

  validates :name, :description, :presence => true

  has_many :server_problems, :dependent => :destroy
  has_many :problems, :through => :server_problems, :dependent => :destroy

  def default_values
    self.port ||= '22'
  end

end
