# encoding: utf-8
class Problem < ActiveRecord::Base
  audit(:create) { |model, user, action| "Проблема \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Проблема \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил проблему \"#{model.name}\"" }

  resourcify

  attr_accessible :description, :name

  validates :name, :description, :presence => true

  has_many :solutions

  has_many :server_problems
  has_many :servers, :through => :server_problems

  has_many :problem_solutions
  has_many :solutions, :through => :problem_solutions

end
