# encoding: utf-8
class Incedent < ActiveRecord::Base
  include ApplicationHelper
  include Workflow

  workflow_column :state

  workflow do
  end

  acts_as_nested_set

  include TheSortableTree::Scopes

  audit(:create)  { |model, user, action| "Жалоба \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Жалоба \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил жалобу \"#{model.name}\"" }

  before_save :default_values, :set_finish_at_to_all

  belongs_to :operator, class_name: 'User', foreign_key: 'operator_id'
  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'
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

  attr_accessible :description, :name, :tags, :incedent_actions, :tag_ids, :operator, :initiator, :worker, :observer, :server, :operator_id, :initiator_id, :priority_id

  attr_accessible :type_id, :status_id, :worker_id, :server_id, :closed, :reject_reason, :replay_reason, :close_reason, :work_reason, :review_reason, :attaches_attributes, :observer_id

  attr_accessible :parent_id, :parent, :childs, :finish_at, :service_class_id, :state, :observers, :reviewers, :workers, :observer_ids, :reviewer_ids, :worker_ids

  attr_accessor :reject_reason, :work_reason, :replay_reason, :close_reason, :review_reason

  scope :not_reviewed, lambda { |user| where("id in (select incedent_id from incedent_reviewers where user_id = ? and reviewed_at is null)", user) unless user.nil? }

  scope :by_tag, lambda {|tag| where("id in (select incedent_id from incedent_tags where tag_id = ?)", tag) unless tag.nil? }

  scope :by_initiator, lambda { |user| where("initiator_id = ?", user) unless user.nil? }

  scope :by_operator, lambda { |user| where("operator_id = ?", user) unless user.nil? }

  scope :by_worker, lambda { |user| where("id in (select incedent_id from incedent_workers where user_id = ?)", user) unless user.nil? }

  scope :by_observer, lambda { |user| where("id in (select incedent_id from incedent_observers where user_id = ?)", user) unless user.nil? }

  scope :by_reviewer, lambda { |user| where("id in (select incedent_id from incedent_reviewers where user_id = ?)", user) unless user.nil? }

  scope :by_initiator_worker_reviewer, lambda { |user| where("(initiator_id = ?) or (id in (select incedent_id from incedent_workers where user_id = ?)) or (id in (select incedent_id from incedent_reviewers where user_id = ?))", user, user, user) unless user.nil? }

  scope :by_operator_initiator_worker_reviewer, lambda { |user| where("(operator_id = ?) or (initiator_id = ?) or (id in (select incedent_id from incedent_workers where user_id = ?)) or (id in (select incedent_id from incedent_reviewers where user_id = ?))", user, user, user, user) unless user.nil? }

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
    self.finish_at ||= get_datetime(DateTime.now, 8)
  end

  def has_worker? user = nil
    if user.nil?
      return self.has_workers?
    else
      self.incedent_workers.each do |worker|
        return true if (worker.worker == user)
      end
    end
    return false
  end

  def has_observer? user = nil
    if user.nil?
      return self.has_observers?
    else
      self.incedent_observers.each do |observer|
        return true if (observer.observer == user)
      end
    end
    return false
  end

  def has_reviewer? user = nil
    if user.nil?
      return self.has_reviewers?
    else
      self.incedent_reviewers.each do |reviewer|
        return true if (reviewer.reviewer == user)
      end
    end
    return false
  end

  def has_reviewed? user = nil
    unless user.nil?
      self.incedent_reviewers.each do |reviewer|
        return true if (reviewer.reviewer == user) and (!reviewer.reviewed_at.nil?)
      end
    end
    return false
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

  def is_overdated_now? user = nil
    unless user.nil?
      self.incedent_workers.each do |worker|
        return (worker.finish_at < get_datetime(DateTime.now, 0)) if (worker.worker == user)
      end
    end
    return (self.finish_at < get_datetime(DateTime.now, 0))
  end

  def is_overdated_soon? user = nil
    unless user.nil?
      self.incedent_workers.each do |worker|
        return ((worker.finish_at >= get_datetime(DateTime.now, 4)) && (worker.finish_at <= get_datetime(DateTime.now, 6))) if (worker.worker == user)
      end
    end
    return ((self.finish_at >= get_datetime(DateTime.now, 4)) && (self.finish_at <= get_datetime(DateTime.now, 6)))
  end

  def is_overdated_review? user = nil
    ((self.has_reviewer? user) && (!self.has_reviewed? user) && (self.has_service_class?) && (get_datetime(self.created_at, self.service_class.review_hours) <= Time.now))
  end

  def is_need_review? user = nil
    unless user.nil?
      ((self.has_reviewer? user) && (!self.has_reviewed? user))
    else
      ((self.has_reviewers?) && (!self.has_reviewed?))
    end
  end

  def is_played? user = nil
    self.get_status Houston::Application.config.incedent_played, user
  end

  def is_paused? user = nil
    self.get_status Houston::Application.config.incedent_paused, user
  end

  def is_stoped? user = nil
    self.get_status Houston::Application.config.incedent_stoped, user
  end

  def is_rejected? user = nil
    self.get_status Houston::Application.config.incedent_rejected, user
  end

  def is_solved? user = nil
    self.status_id == Houston::Application.config.incedent_solved or self.closed
  end

  def is_closed? user = nil
    unless user.nil?
      return self.get_status Houston::Application.config.incedent_closed, user
    else
      self.incedent_workers.each do |worker|
        return true if (self.is_closed? worker.worker)
      end
    end
  end

  def is_waited? user = nil
    self.get_status Houston::Application.config.incedent_waited, user
  end

  def delete_observer user
     self.incedent_observers.each do |observer|
        observer.destroy if (observer.observer == user)
     end
  end

  def delete_observers
     self.incedent_observers.each do |observer|
        observer.destroy
     end
  end

  def add_observer user
    IncedentObserver.create(incedent: self, observer: user).save
  end

  def delete_worker user
    self.incedent_workers.each do |worker|
      worker.destroy if (worker.worker == user)
    end
  end

  def delete_workers
    self.incedent_workers.each do |worker|
      worker.destroy
    end
  end

  def add_worker user, status = 3
    IncedentWorker.create(incedent: self, worker: user, status_id: status).save
  end

  def delete_reviewer user
    self.incedent_reviewers.each do |reviewer|
      reviewer.destroy if (reviewer.reviewer == user)
    end
  end

  def delete_reviewers
    self.incedent_reviewers.each do |reviewer|
      reviewer.destroy
    end
  end

  def add_reviewer user
    IncedentReviewer.create(incedent: self, reviewer: user).save
  end

  def played! user = nil
    unless user.nil?
      if self.is_need_review? user
        self.waited! user
      else
        self.set_status Houston::Application.config.incedent_played, user
        self.closed = false
      end
    else
      if self.is_need_review?
        self.set_status_all Houston::Application.config.incedent_waited
        self.status_id = Houston::Application.config.incedent_waited
        self.closed = false
      else
        self.set_status_all Houston::Application.config.incedent_played
        self.status_id = Houston::Application.config.incedent_played
        self.closed = false
      end
    end
  end

  def paused! user = nil
    self.set_status Houston::Application.config.incedent_paused, user
    self.closed = false
  end

  def stoped! user = nil
    self.set_status Houston::Application.config.incedent_stoped, user
    self.closed = false
  end

  def rejected! user = nil
    self.set_status Houston::Application.config.incedent_rejected, user
    self.closed = false
  end

  def reviewed! user = nil
    unless user.nil?
      self.incedent_reviewers.each do |reviewer|
        if (reviewer.reviewer == user)
          reviewer.reviewed_at = Time.now
          reviewer.save
        end
      end
    else
      self.incedent_reviewers.each do |reviewer|
        reviewer.reviewed_at = Time.now
        reviewer.save
      end
    end
  end

  def unreviewed! user = nil
    unless user.nil?
      self.incedent_reviewers.each do |reviewer|
        if (reviewer.reviewer == user)
          reviewer.reviewed_at = nil
          reviewer.save
        end
      end
    else
      self.incedent_reviewers.each do |reviewer|
        reviewer.reviewed_at = nil
        reviewer.save
      end
    end
  end

  def solved!
    self.status_id = Houston::Application.config.incedent_solved
    self.set_status_all Houston::Application.config.incedent_solved
    self.closed = true
  end

  def closed! user = nil
    self.set_status Houston::Application.config.incedent_closed, user
    self.closed = false
  end

  def waited! user = nil
    self.set_status Houston::Application.config.incedent_waited, user
    self.status_id = Houston::Application.config.incedent_waited
    self.closed = false
  end

  def set_status status, user = nil
    unless user.nil?
      if self.has_worker? user
        self.incedent_workers.each do |worker|
          if (worker.worker == user)
            worker.status_id = status
            worker.save
          end
        end
        self.save
      else
        self.add_worker user, status unless (self.initiator == user) or (self.operator == user)
      end
    else
      self.status_id = status
    end
  end

  def set_status_all status
    if self.has_workers?
      self.incedent_workers.each do |worker|
        worker.status_id = status
        worker.save
      end
    end
    self.status_id = status
  end

  def set_finish_at_to_all
    if self.has_workers?
      self.incedent_workers.each do |worker|
        worker.finish_at = self.finish_at unless worker.destroyed?
        worker.save unless worker.destroyed?
      end
    end
  end

  def get_status status, user = nil
    self.incedent_workers.each do |worker|
      unless user.nil?
        return (worker.status_id == status) if (worker.worker == user)
      else
        return false if (worker.status_id != status)
      end
    end
    return false
  end

  def get_status_id user = nil
    self.incedent_workers.each do |worker|
      unless user.nil?
        return worker.status_id if (worker.worker == user)
      end
    end
    return self.status_id
  end

  def get_status_name user = nil
    self.incedent_workers.each do |worker|
      unless user.nil?
        return worker.status.name if (worker.worker == user)
      end
    end
    return self.status.name
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
      @incedents = Incedent.solved(false).by_worker(user)
      unless @incedents.empty?
        IncedentMailer.incedents_in_progress(@incedents, user).deliver
      end
    end
  end

  def self.autoclose!
      Incedent.closed.each do |incedent|
        unless incedent.service_class.nil?
           if (incedent.service_class.autoclose) and get_datetime(incedent.created_at, incedent.service_class.autoclose_hours) > Time.now
             incedent.add_worker User.find(1) unless incedent.has_workers?
             incedent.solved!
             IncedentAction.create(incedent: incedent, status: incedent.status, worker: incedent.workers).save
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