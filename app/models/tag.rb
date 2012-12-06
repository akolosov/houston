# encoding: utf-8
class Tag < ActiveRecord::Base
  audit(:create) { |model, user, action| "Метка \"#{model.name}\" создана пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Метка \"#{model.name}\" изменена пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил метку \"#{model.name}\"" }

  resourcify

  has_many :problem_tags, dependent: :destroy
  has_many :problems, through: :problem_tags, dependent: :destroy

  attr_accessible :name

  validates :name, presence: true

end
