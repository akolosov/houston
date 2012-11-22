# encoding: utf-8
class ProblemSolution < ActiveRecord::Base
  audit(:create) { |model, user, action| "Решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\" создано, пользователь: #{user.display_name}" }
  audit(:update) { |model, user, action| "Решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\" изменено, пользователь: #{user.display_name}" }
  audit(:destroy) { |model, user, action| "#{user.display_name} удалил решение \"#{model.solution.name}\" для проблемы \"#{model.problem.name}\"" }

  belongs_to :problem
  belongs_to :solution

  validates :problem, :presence => true
  validates :solution, :presence => true

  attr_accessible :problem_id, :solution_id, :problem, :solution, :params, :command_id, :server_id

  attr :command_id, :server_id, :params

end
