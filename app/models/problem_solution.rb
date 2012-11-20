class ProblemSolution < ActiveRecord::Base
  belongs_to :problem
  belongs_to :solution

  attr_accessible :problem_id, :solution_id, :problem, :solution, :params
end
