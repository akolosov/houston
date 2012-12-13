class IncedentComment < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :comment
  # attr_accessible :title, :body
end
