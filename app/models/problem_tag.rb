class ProblemTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :problem
  
  attr_accessible :tag_id, :problem_id
end
