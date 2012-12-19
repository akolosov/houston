# encoding: utf-8
class Incedent < ActiveRecord::Base
  audit(:create)  { |model, user, action| "Жалоба \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Жалоба \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил жалобу \"#{model.name}\"" }

  belongs_to :initiator, class_name: 'User', foreign_key: "initiator_id"
  belongs_to :worker, class_name: 'User', foreign_key: "worker_id"
  belongs_to :status
  belongs_to :priority
  belongs_to :type
  
  validates :name, :description, presence: true

  has_many :incedent_tags, dependent: :destroy
  has_many :tags, through: :incedent_tags, dependent: :destroy

  has_many :incedent_comments, dependent: :destroy
  has_many :comments, through: :incedent_comments, dependent: :destroy

  has_many :incedent_actions

  attr_accessible :description, :name, :tags, :tag_ids, :initiator_id, :priority_id, :type_id, :status_id, :worker_id, :closed

  def has_worker?
    !self.worker.nil?
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

  def self.incedents_by_tag(tag)
    where("id in (select incedent_id from incedent_tags where tag_id = #{tag.id})")
  end

  def self.incedents_by_user_as_initiator(user)
    where("initiator_id = #{user.id}")
  end

  def self.incedents_by_null_worker
    where("worker_id is null")
  end

  def self.incedents_by_not_null_worker
    where("worker_id is not null")
  end

  def self.incedents_by_user_as_worker(user)
    where("worker_id = #{user.id}")
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

  def self.incedents_by_priority(priority)
    where("priority_id = #{priority.id}")
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |incedent|
        csv << incedent.attributes.values_at(*column_names)
      end
    end
  end

end
