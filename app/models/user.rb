# encoding: utf-8
class User < ActiveRecord::Base
  store_configurable
  rolify

  before_create :default_config

  attr_accessible :username, :email, :password, :password_confirmation, :realname, :jabber, :role_ids, :division, :division_id

  attr_accessible :worked_incedent_ids, :observed_incedent_ids, :reviewed_incedent_ids, :config

  alias_attribute :name, :username

  authenticates_with_sorcery!

  has_many :documents, dependent: :destroy

  before_destroy { |record| Document.update_all "user_id = 1", "user_id = #{record.id}" }

  has_many :created_incedents, class_name: 'Incedent', dependent: :destroy, foreign_key: 'operator_id'

  before_destroy { |record| Incedent.update_all "operator_id = 1", "operator_id = #{record.id}" }

  has_many :owned_incedents, class_name: 'Incedent', dependent: :destroy, foreign_key: 'initiator_id'

  before_destroy { |record| Incedent.update_all "initiator_id = 1", "initiator_id = #{record.id}" }

  has_many :worked_incedents, class_name: 'IncedentWorker', dependent: :destroy

  before_destroy { |record| IncedentWorker.update_all "user_id = 1", "user_id = #{record.id}" }

  has_many :observed_incedents, class_name: 'IncedentObserver', dependent: :destroy

  before_destroy { |record| IncedentObserver.update_all "user_id = 1", "user_id = #{record.id}" }

  has_many :reviewed_incedents, class_name: 'IncedentReviewer', dependent: :destroy

  before_destroy { |record| Incedent.update_all "user_id = 1", "user_id = #{record.id}" }

  has_many :incedent_actions, dependent: :destroy, foreign_key: 'worker_id'

  before_destroy { |record| IncedentAction.update_all "worker_id = 1", "worker_id = #{record.id}" }

  has_many :comments, dependent: :destroy, foreign_key: 'author_id'

  before_destroy { |record| Comment.update_all "author_id = 1", "author_id = #{record.id}" }

  validates_length_of :password, minimum: 3, message: 'Пароль должен быть длиннее 3 символов', if: :password

  validates_confirmation_of :password, message: 'Пароли не совпадают', if: :password

  validates_presence_of :username, message: 'Не указано имя пользователя'

  validates_uniqueness_of :username, message: 'Такое имя уже используется'

  validates_presence_of :email, message: 'Не указан e-mail пользователя'

  validates_uniqueness_of :email, message: 'Такой e-mail уже зарегистрирован'

  belongs_to :division

  scope :by_division, lambda { |division| where("division_id = ?", division) unless division.nil? }

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

  def first_login_success!
    self.first_login = false
    self.save
  end

  def first_login_fail!
    self.first_login = true
    self.save
  end

  def to_label
    "#{realname}"
  end

  def self.users_by_role_id(role_id)
    where("id in (select user_id from users_roles where role_id = ?) and active = ?", role_id, true)
  end

  def self.active
    where("active = ?", true)
  end

  def self.inactive
    where("active = ?", false)
  end

  def has_roles? roles = []
    roles.each do |role|
      true if self.has_role? role
    end
    false
  end

  def self.set_default_config
    User.all.each do |user|
      user.save
    end
  end

  protected

  def default_config
    self.config.table_count = 20
    self.config.tree_count = 20
    self.config.list_count = 5
    self.config.refresh_interval = 180
    self.config.time_zone = Houston::Application.config.time_zone
  end
end
