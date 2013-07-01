class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :document_comments, dependent: :destroy
  has_many :documents, through: :document_comments, dependent: :destroy

  has_many :incedent_comments, dependent: :destroy
  has_many :incedents, through: :incedent_comments, dependent: :destroy

  has_many :comment_attaches, dependent: :destroy
  has_many :attaches, through: :comment_attaches, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  attr_accessible :body, :title, :author, :author_id
end
