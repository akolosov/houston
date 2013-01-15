class IncedentAttach < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :attach

  attr_accessible :attach_id, :incedent_id
end
