class Comment < ActiveRecord::Base
  default_scope order('created_at')

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :document_comments, dependent: :delete_all
  has_many :documents, through: :document_comments, dependent: :delete_all

  has_many :incedent_comments, dependent: :delete_all
  has_many :incedents, through: :incedent_comments, dependent: :delete_all

  has_many :comment_attaches, dependent: :delete_all
  has_many :attaches, through: :comment_attaches, dependent: :delete_all

  validates :title, presence: true
  validates :body, presence: true

  attr_accessible :body, :title, :author, :author_id
end
