class IncedentTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :incedent

  attr_accessible :tag_id, :incedent_id
end
