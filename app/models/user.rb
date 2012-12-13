# encoding: utf-8
class User < ActiveRecord::Base
  rolify

  attr_accessible :username, :email, :password, :password_confirmation, :realname

  alias_attribute :name, :username

  authenticates_with_sorcery!

  has_many :documents, dependent: :destroy

  has_many :owned_incedents, dependent: :destroy, foreign_key: "initiator_id"

  has_many :worked_incedents, dependent: :destroy, foreign_key: "worker_id"

  has_many :incedent_actions, dependent: :destroy, foreign_key: "worker_id"

  has_many :comments, dependent: :destroy, foreign_key: "author_id"

  validates_length_of :password, minimum: 3, message: "Пароль должен быть длиннее 3 символов", if: :password

  validates_confirmation_of :password, message: "Пароли не совпадают", if: :password

  def display_name
    self.realname+" ("+self.email+")"
  end

end
