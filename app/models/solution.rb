# encoding: utf-8
class Solution < ActiveRecord::Base
  audit(:create) { |model, user, action| "Решение \"#{model.name}\" создано пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Решение \"#{model.name}\" изменено пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил решение \"#{model.name}\"" }

  resourcify

  has_many :problem_solutions, dependent: :delete_all
  has_many :problems, through: :problem_solutions, dependent: :delete_all

  attr_accessible :description, :name

  validates :name, :description, presence: true

  def self.solutions_for_problem(problem)
    where("id in (select solution_id from problem_solutions where problem_id = #{problem.id})")
  end

  def self.solution_for_problem(problem)
    where("id in (select solution_id from problem_solutions where problem_id = #{problem.id})").first
  end

  def self.search(query)
    where("name like '%#{query}%' or description like '%#{query}%'")
  end

end
