class Attach < ActiveRecord::Base
  attr_accessible :description, :mime, :name, :size, :file

  has_many :incedent_attaches, dependent: :destroy
  has_many :incedents, through: :incedent_attaches, dependent: :destroy

  has_many :comment_attaches, dependent: :destroy
  has_many :comments, through: :comment_attaches, dependent: :destroy
  
  has_many :document_attaches, dependent: :destroy
  has_many :documents, through: :document_attaches, dependent: :destroy
  
  accepts_nested_attributes_for :incedents, :documents, :comments

end
