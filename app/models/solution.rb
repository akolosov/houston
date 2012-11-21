class Solution < ActiveRecord::Base
  resourcify

  belongs_to :command

  has_many :problem_solutions
  has_many :problems, :through => :problem_solutions

  attr_accessible :command_id, :command, :description, :name

  validates :name, :description, :presence => true

  def self.solutions_with_command(command)
    where("command_id = #{command.id}")
  end

  def self.solution_with_command(command)
    where("command_id = #{command.id}").first
  end

  def self.solutions_for_problem(problem)
    where("id in (select solution_id from problem_solutions where problem_id = #{problem.id})")
  end

  def self.solution_for_problem(problem)
    where("id in (select solution_id from problem_solutions where problem_id = #{problem.id})").first
  end

  def servers
  end

  def params
  end
end
