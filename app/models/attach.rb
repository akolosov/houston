class Attach < ActiveRecord::Base
  attr_accessible :description, :mime, :name, :size, :file

  has_many :incedent_attaches, dependent: :delete_all
  has_many :incedents, through: :incedent_attaches, dependent: :delete_all

  has_many :comment_attaches, dependent: :delete_all
  has_many :comments, through: :comment_attaches, dependent: :delete_all
  
  has_many :document_attaches, dependent: :delete_all
  has_many :documents, through: :document_attaches, dependent: :delete_all

  has_many :server_attaches, dependent: :delete_all
  has_many :servers, through: :server_attaches, dependent: :delete_all
  
  accepts_nested_attributes_for :incedents, :documents, :comments, :servers

end
