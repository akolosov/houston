# encoding: utf-8
class User < ActiveRecord::Base
  rolify

  attr_accessible :username, :email, :password, :password_confirmation, :providers_attributes

  alias_attribute :name, :username

  authenticates_with_sorcery!

  has_many :documents

  validates_length_of :password, :minimum => 3, :message => "Пароль должен быть длиннее 3 символов", :if => :password

  validates_confirmation_of :password, :message => "Пароли не совпадают", :if => :password

  def display_name
    self.username+" ("+self.email+")"
  end

end
