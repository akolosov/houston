class IncedentWorker < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :worker, class_name: 'User', foreign_key: 'user_id'
  belongs_to :status

  attr_accessible :incedent, :worker, :status, :incedent_id, :user_id, :status_id

  validates_uniqueness_of :incedent_id, scope: :user_id, message: 'Этот исполнитель уже назначен на данную жалобу!'
end
