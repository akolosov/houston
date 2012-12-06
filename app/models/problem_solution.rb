# encoding: utf-8
class ProblemSolution < ActiveRecord::Base
  audit(:create)  { |model, user, action| "Решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\" создано пользователем #{user.display_name}" }
  audit(:update)  { |model, user, action| "Решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\" изменено пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\"" }

  belongs_to :problem
  belongs_to :solution

  validates :solution, :problem, presence: true

  attr_accessible :problem_id, :solution_id, :problem, :solution

end
