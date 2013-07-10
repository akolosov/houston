# encoding: utf-8
class Incedent < ActiveRecord::Base
  audit(:create)  { |model, user, action| "Жалоба \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Жалоба \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил жалобу \"#{model.name}\"" }

  belongs_to :initiator, class_name: 'User', foreign_key: 'initiator_id'
  belongs_to :worker, class_name: 'User', foreign_key: 'worker_id'
  belongs_to :observer, class_name: 'User', foreign_key: 'observer_id'
  belongs_to :status
  belongs_to :priority
  belongs_to :type
  belongs_to :server

  validates :name, :description, presence: true

  has_many :incedent_tags, dependent: :delete_all
  has_many :tags, through: :incedent_tags, dependent: :delete_all

  has_many :incedent_comments, dependent: :delete_all
  has_many :comments, through: :incedent_comments, dependent: :delete_all

  has_many :incedent_attaches, dependent: :delete_all
  has_many :attaches, through: :incedent_attaches, dependent: :delete_all

  has_many :incedent_actions
  
  accepts_nested_attributes_for :attaches, allow_destroy: true

  attr_accessible :description, :name, :tags, :incedent_actions, :tag_ids, :initiator, :worker, :observer, :server, :initiator_id, :priority_id, :type_id, :status_id, :worker_id, :server_id
  attr_accessible :closed, :reject_reason, :replay_reason, :close_reason, :work_reason, :attaches_attributes, :observer_id
   
  def reject_reason    
  end

  def work_reason
  end

  def replay_reason    
  end

  def close_reason    
  end

  def has_worker?
    !self.worker.nil?
  end

  def has_observer?
    !self.observer.nil?
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

  def played!
    self.status_id = Houston::Application.config.incedent_played
    self.closed = false
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

  def self.incedents_by_tag(tag)
    where("id in (select incedent_id from incedent_tags where tag_id = #{tag.id})")
  end

  def self.incedents_by_user_as_initiator(user)
    where("initiator_id = #{user.id}")
  end

  def self.incedents_by_null_worker
    where('worker_id is null')
  end

  def self.incedents_by_not_null_worker
    where('worker_id is not null')
  end

  def self.incedents_by_null_observer
    where('observer_id is null')
  end

  def self.incedents_by_not_null_observer
    where('observer_id is not null')
  end

  def self.incedents_by_user_as_worker(user)
    where("worker_id = #{user.id}")
  end

  def self.incedents_by_user_as_observer(user)
    where("observer_id = #{user.id}")
  end

  def self.incedents_by_user_as_initiator_or_worker(user)
    where("initiator_id = #{user.id} or worker_id = #{user.id}")
  end

  def self.incedents_by_type(type)
    where("type_id = #{type.id}")
  end

  def self.incedents_by_status(status)
    where("status_id = #{status.id}")
  end

  def self.incedents_by_server(server)
    where("server_id = #{server.id}")
  end

  def self.incedents_by_priority(priority)
    where("priority_id = #{priority.id}")
  end

  def self.incedents_by_user(user)
    where("initiator_id = #{user.id} or worker_id = #{user.id} or observer_id = #{user.id}")
  end

  def self.solved_incedents(archive)
    where('closed = ?', archive)
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

end
