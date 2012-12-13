class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: "author_id"

  has_many :document_comments, dependent: :destroy
  has_many :documents, through: :document_comments, dependent: :destroy

  has_many :incedent_comments, dependent: :destroy
  has_many :incedents, through: :incedent_comments, dependent: :destroy

  attr_accessible :body, :title, :author_id
end
