class IncedentObserver < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :observer, class_name: 'User', foreign_key: 'user_id'

  attr_accessible :incedent, :observer, :incedent_id, :user_id

  validates_uniqueness_of :incedent_id, scope: :user_id, message: 'Этот наблюдатель уже назначен на данную жалобу!'
end
