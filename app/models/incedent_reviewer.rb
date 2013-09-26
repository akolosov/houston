class IncedentReviewer < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :reviewer, class_name: 'User', foreign_key: 'user_id'

  attr_accessible :incedent, :reviewer, :reviewed_at, :incedent_id, :user_id

  validates_uniqueness_of :incedent_id, scope: :user_id, message: 'Этот пользователь уже назначен на согласование данной жалобы!'
end
