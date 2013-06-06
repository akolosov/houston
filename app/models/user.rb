# encoding: utf-8
class User < ActiveRecord::Base
  rolify

  attr_accessible :username, :email, :password, :password_confirmation, :realname

  alias_attribute :name, :username

  authenticates_with_sorcery!

  has_many :documents, dependent: :destroy

  before_destroy { |record| Document.update_all "user_id = 1", "user_id = #{record.id}" }

  has_many :owned_incedents, class_name: 'Incedent', dependent: :destroy, foreign_key: 'initiator_id'

  before_destroy { |record| Incedent.update_all "initiator_id = 1", "initiator_id = #{record.id}" }

  has_many :worked_incedents, class_name: 'Incedent', dependent: :destroy, foreign_key: 'worker_id'

  before_destroy { |record| Incedent.update_all "worker_id = 1", "worker_id = #{record.id}" }

  has_many :incedent_actions, dependent: :destroy, foreign_key: 'worker_id'

  before_destroy { |record| IncedentAction.update_all "worker_id = 1", "worker_id = #{record.id}" }

  has_many :comments, dependent: :destroy, foreign_key: 'author_id'

  before_destroy { |record| Comment.update_all "author_id = 1", "author_id = #{record.id}" }

  validates_length_of :password, minimum: 3, message: 'Пароль должен быть длиннее 3 символов', if: :password

  validates_confirmation_of :password, message: 'Пароли не совпадают', if: :password

  def display_name
    self.realname+' ('+self.email+')'
  end

  def activate!
    self.active = true
    self.save
  end

  def deactivate!
    self.active = false
    self.save
  end

  def to_label
    "#{realname}"
  end
  
end
