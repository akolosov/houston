class IncedentComment < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :comment

  attr_accessible :incedent, :comment, :incedent_id, :comment_id
end
