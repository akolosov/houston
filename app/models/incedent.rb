# encoding: utf-8
class Incedent < ActiveRecord::Base
  include Workflow

  workflow_column :state

  workflow do

  end

  acts_as_nested_set

  include TheSortableTree::Scopes

  audit(:create)  { |model, user, action| "Жалоба \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Жалоба \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил жалобу \"#{model.name}\"" }

  before_save :default_values

  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id'
  belongs_to :observer, class_name: 'User', foreign_key: 'observer_id'
  belongs_to :operator, class_name: 'User', foreign_key: 'operator_id'
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'
  belongs_to :status
  belongs_to :priority
  belongs_to :type
  belongs_to :server
  belongs_to :service_class
  belongs_to :parent,
             :class_name => "Incedent",
             :foreign_key => "parent_id"

  validates :name, :description, presence: true

  has_many :incedent_observers, dependent: :delete_all
  has_many :observers, through: :incedent_observers, dependent: :delete_all

  has_many :incedent_workers, dependent: :delete_all
  has_many :workers, through: :incedent_workers, dependent: :delete_all

  has_many :incedent_reviewers, dependent: :delete_all
  has_many :reviewers, through: :incedent_reviewers, dependent: :delete_all

  has_many :incedent_tags, dependent: :delete_all
  has_many :tags, through: :incedent_tags, dependent: :delete_all

  has_many :incedent_comments, dependent: :delete_all
  has_many :comments, through: :incedent_comments, dependent: :delete_all

  has_many :incedent_attaches, dependent: :delete_all
  has_many :attaches, through: :incedent_attaches, dependent: :delete_all

  has_many :incedent_actions

  has_many :childs,
           :class_name => "Incedent",
           :foreign_key => "parent_id",
           :order => "name",
           :dependent => :delete_all

  accepts_nested_attributes_for :attaches, allow_destroy: true

  attr_accessible :description, :name, :tags, :incedent_actions, :tag_ids, :operator, :initiator, :worker, :observer, :reviewer, :server, :operator_id, :initiator_id, :priority_id

  attr_accessible :type_id, :status_id, :worker_id, :server_id, :closed, :reject_reason, :replay_reason, :close_reason, :work_reason, :review_reason, :attaches_attributes, :observer_id, :reviewer_id

  attr_accessible :parent_id, :parent, :childs, :finish_at, :service_class_id, :state, :observers, :reviewers, :workers, :observer_ids, :reviewer_ids, :worker_ids

  attr_accessor :reject_reason, :work_reason, :replay_reason, :close_reason, :review_reason

  scope :by_null_worker, where('worker_id is null')

  scope :by_not_null_worker, where('worker_id is not null')

  scope :by_null_observer, where('observer_id is null')

  scope :by_not_null_observer, where('observer_id is not null')

  scope :by_null_reviewer, where('reviewer_id is null')

  scope :by_not_null_reviewer, where('reviewer_id is not null')

  scope :not_reviewed, lambda { |user| where("id in (select incedent_id from incedent_reviewers where user_id = ? and reviewed_at is null)", user) unless user.nil? }

  scope :by_tag, lambda {|tag| where("id in (select incedent_id from incedent_tags where tag_id = ?)", tag) unless tag.nil? }

  scope :by_initiator, lambda { |user| where("initiator_id = ?", user) unless user.nil? }

  scope :by_operator, lambda { |user| where("operator_id = ?", user) unless user.nil? }

  scope :by_worker, lambda { |user| where("id in (select incedent_id from incedent_workers where user_id = ?)", user) unless user.nil? }

  scope :by_observer, lambda { |user| where("id in (select incedent_id from incedent_observers where user_id = ?)", user) unless user.nil? }

  scope :by_reviewer, lambda { |user| where("id in (select incedent_id from incedent_reviewers where user_id = ?)", user) unless user.nil? }

  scope :by_initiator_worker_reviewer, lambda { |user| where("initiator_id = ? or id in (select incedent_id from incedent_workers where user_id = ?) or id in (select incedent_id from incedent_reviewers where user_id = ?)", user, user, user) unless user.nil? }

  scope :by_type, lambda { |type| where("type_id = ?", type) unless type.nil? }

  scope :by_status, lambda { |status| where("status_id = ?", status) unless status.nil? }

  scope :by_server, lambda { |server| where("server_id = ?", server) unless server.nil? }

  scope :by_priority, lambda { |priority| where("priority_id = ?", priority) unless priority.nil? }

  scope :by_parent, lambda { |parent| where("parent_id = ?", parent) unless parent.nil? }

  scope :solved, lambda { |archive| where('closed = ?', archive) }

  scope :closed, where("status_id = ? and closed = ?", Houston::Application.config.incedent_closed, false)

  def has_parent?
    !self.parent_id.nil?
  end

  def have_childs?
    !self.childs.empty?
  end

  def parents_count
    count = 0
    if self.has_parent?
      count = 1
      count += self.parent.parents_count
    end
    count
  end

  def default_values
    self.initiator_id ||= 1
    self.operator_id ||= self.initiator_id
    self.finish_at ||= Time.now + 1.days
  end

  def has_worker? worker = nil
    if worker.nil?
      self.has_workers?
    else
      self.workers.include? worker
    end
  end

  def has_observer? observer = nil
    if observer.nil?
      self.has_observers?
    else
      self.observers.include? observer
    end
  end

  def has_reviewer? reviewer = nil
    if reviewer.nil?
      self.has_reviewers?
    else
      self.reviewers.include? reviewer
    end
  end

  def has_reviewed? reviewer = nil
    unless reviewer.nil?
      if self.reviewers.include? reviewer
        self.reviewers.each do |user|
          true if (user == reviewer) and (user.reviewed_at)
        end
      end
    end
  end

  def has_workers?
    !self.workers.empty?
  end

  def has_observers?
    !self.observers.empty?
  end

  def has_reviewers?
    !self.reviewers.empty?
  end

  def has_operator?
    !self.operator.nil?
  end

  def has_initiator?
    !self.initiator.nil?
  end

  def has_service_class?
    !self.service_class.nil?
  end

  def is_overdated_now?
    (self.finish_at < Time.now)
  end

  def is_overdated_soon?
    ((self.finish_at >= (Time.now - 4.hours)) && (self.finish_at <= (Time.now + 6.hours)))
  end

  def is_overdated_review? user = nil
    ((self.has_reviewer? user) && (!self.has_reviewed? user) && (self.has_service_class?) && ((self.created_at + self.service_class.review_hours.hours) <= Time.now))
  end

  def is_need_review? user = nil
    ((self.is_waited?) && (self.has_reviewer? user) && (!self.has_reviewed? user))
  end

  def is_played?
    self.status_id == Houston::Application.config.incedent_played
  end

  def is_paused?
    self.status_id == Houston::Application.config.incedent_paused
  end

  def is_stoped?
    self.status_id == Houston::Application.config.incedent_stoped
  end

  def is_rejected?
    self.status_id == Houston::Application.config.incedent_rejected
  end

  def is_solved?
    self.status_id == Houston::Application.config.incedent_solved or self.closed
  end

  def is_closed?
    self.status_id == Houston::Application.config.incedent_closed
  end

  def is_waited?
    self.status_id == Houston::Application.config.incedent_waited
  end

  def delete_observer user
     self.observers.each do |observer|
        observer.destroy if (observer.observer == user)
     end
  end

  def add_observer user
    IncedentObserver.create(incedent: self, observer: user).save
  end

  def delete_worker user
    self.workers.each do |worker|
      worker.destroy if (worker.worker == user)
    end
  end

  def add_worker user
    IncedentWorker.create(incedent: self, worker: user, status_id: Houston::Application.config.incedent_paused).save
  end

  def delete_reviewer user
    self.reviewers.each do |reviewer|
      reviewer.destroy if (reviewer.reviewer == user)
    end
  end

  def add_reviewer user
    IncedentReviewer.create(incedent: self, reviewer: user).save
  end

  def played!
    if self.is_need_review?
      self.waited!
    else
      self.status_id = Houston::Application.config.incedent_played
      self.closed = false
    end
  end

  def paused!
    self.status_id = Houston::Application.config.incedent_paused
    self.closed = false
  end

  def stoped!
    self.status_id = Houston::Application.config.incedent_stoped
    self.closed = false
  end

  def rejected!
    self.status_id = Houston::Application.config.incedent_rejected
    self.closed = false
  end

  def reviewed!
    self.reviewed_at = Time.now
    if self.has_worker?
      self.played!
    else
      self.paused!
    end
  end

  def solved!
    self.status_id = Houston::Application.config.incedent_solved
    self.closed = true
  end

  def closed!
    self.status_id = Houston::Application.config.incedent_closed
    self.closed = false
  end

  def waited!
    self.status_id = Houston::Application.config.incedent_waited
  end

  def self.prepare_for_multiple
    Incedent.all.each do |incedent|
      unless incedent.worker.nil?
        IncedentWorker.create(incedent: incedent, user: incedent.worker, status: incedent.status).save
      end

      unless incedent.observer.nil?
        IncedentObserver.create(incedent: incedent, user: incedent.observer).save
      end

      unless incedent.reviewer.nil?
        IncedentReviewer.create(incedent: incedent, user: incedent.reviewer, reviewed_at: incedent.reviewed_at).save
      end
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |incedent|
        csv << incedent.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(query)
    where("name like '%#{query}%' or description like '%#{query}%'")
  end

  def self.notify_workers
    User.active.each do |user|
      @incedents = Incedent.solved(false).by_user_as_worker(user)
      unless @incedents.empty?
        IncedentMailer.incedents_in_progress(@incedents).deliver
      end
    end
  end

  def self.autoclose!
      Incedent.closed.each do |incedent|
        unless incedent.service_class.nil?
           if (incedent.service_class.autoclose) and (incedent.created_at + incedent.service_class.autoclose_hours.hours) > Time.now
             incedent.worker = User.find(1) unless incedent.has_worker?
             incedent.solved!
             IncedentAction.create(incedent: incedent, status: incedent.status, worker: incedent.worker).save
           end
        end
      end
    end
end

class TheIncedent < Incedent

end

class TheProblem < Incedent

end

class TheSupport < Incedent

end

class TheChange < Incedent

end