# encoding: utf-8
class User < ActiveRecord::Base
  audit(:create) { |model, user, action| "Пользователь \"#{model.name}\" создан, пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Пользователь \"#{model.name}\" изменен, пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил пользователя \"#{model.name}\"" }

  rolify

  attr_accessible :username, :email, :password, :password_confirmation, :providers_attributes

  alias_attribute :name, :username

  authenticates_with_sorcery!

  validates_length_of :password, :minimum => 3, :message => "Пароль должен быть длиннее 3 символов", :if => :password

  validates_confirmation_of :password, :message => "Пароли не совпадают", :if => :password

  def display_name
    self.username+" ("+self.email+")"
  end

end
