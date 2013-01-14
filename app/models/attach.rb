class Attach < ActiveRecord::Base
  attr_accessible :description, :mime, :name, :size, :file
  
  has_many :incedent_attaches, dependent: :destroy
  has_many :incedents, through: :incedent_attaches, dependent: :destroy

  has_many :comment_attaches, dependent: :destroy
  has_many :comments, through: :comment_attaches, dependent: :destroy
  
  def file
  end
end
