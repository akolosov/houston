# encoding: utf-8
class Document < ActiveRecord::Base
  audit(:create) { |model, user, action| "Рецепт \"#{model.title}\" создан пользователем #{user.display_name}" }
  audit(:update) { |model, user, action| "Рецепт \"#{model.title}\" изменен пользователем #{user.display_name}" }
  audit(:destroy) { |model, user, action| "Пользователь #{user.display_name} удалил рецепт \"#{model.title}\"" }

  belongs_to :user

  has_many :document_comments, dependent: :delete_all
  has_many :comments, through: :document_comments, dependent: :delete_all

  attr_accessible :body, :title, :user, :user_id, :attaches_attributes

  validates :title, :body, presence: true

  has_many :document_attaches, dependent: :delete_all
  has_many :attaches, through: :document_attaches, dependent: :delete_all

  accepts_nested_attributes_for :attaches, allow_destroy: true

  def self.search(query)
    where("title like '%#{query}%' or body like '%#{query}%'")
  end

end