class Attach < ActiveRecord::Base
  attr_accessible :description, :mime, :name, :size, :file

  has_many :incedent_attaches
  has_many :incedents, through: :incedent_attaches, dependent: :delete_all

  has_many :comment_attaches
  has_many :comments, through: :comment_attaches, dependent: :delete_all
  
  has_many :document_attaches
  has_many :documents, through: :document_attaches, dependent: :delete_all
  
  accepts_nested_attributes_for :incedents, :documents, :comments

end
