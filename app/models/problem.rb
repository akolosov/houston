# encoding: utf-8
class Problem < ActiveRecord::Base
  audit(:create) { |model, user, action| "Проблема \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Проблема \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил проблему \"#{model.name}\"" }

  resourcify

  attr_accessible :description, :name, :tags, :tag_ids, :solutions, :servers, :solution_ids, :server_ids

  validates :name, :description, presence: true

  has_many :server_problems, dependent: :delete_all
  has_many :servers, through: :server_problems, dependent: :delete_all

  has_many :problem_solutions, dependent: :delete_all
  has_many :solutions, through: :problem_solutions, dependent: :delete_all

  has_many :problem_tags, dependent: :delete_all
  has_many :tags, through: :problem_tags, dependent: :delete_all

  def self.problems_by_tag(tag)
    where("id in (select problem_id from problem_tags where tag_id = #{tag.id})")
  end

  def self.problems_by_solution(solution)
    where("id in (select problem_id from problem_solutions where solution_id = #{solution.id})")
  end

  def self.search(query)
    where("name like '%#{query}%' or description like '%#{query}%'")
  end

end
