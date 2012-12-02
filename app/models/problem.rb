# encoding: utf-8
class Problem < ActiveRecord::Base
  audit(:create) { |model, user, action| "Проблема \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Проблема \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил проблему \"#{model.name}\"" }

  resourcify

  attr_accessible :description, :name, :tags

  validates :name, :description, :presence => true

  has_many :server_problems
  has_many :servers, :through => :server_problems

  has_many :problem_solutions
  has_many :solutions, :through => :problem_solutions

  has_many :problem_tags
  has_many :tags, :through => :problem_tags

  def self.problems_by_tag(tag)
    where("id in (select problem_id from problem_tags where tag_id = #{tag.id})")
  end

end
