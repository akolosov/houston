# encoding: utf-8
class Document < ActiveRecord::Base
  audit(:create) { |model, user, action| "Рецепт \"#{model.title}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Рецепт \"#{model.title}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил рецепт \"#{model.title}\"" }

  belongs_to :user

  has_many :document_comments, dependent: :destroy
  has_many :comments, through: :document_comments, dependent: :destroy

  attr_accessible :body, :title, :user, :user_id
  
  validates :title, :body, presence: true
end
