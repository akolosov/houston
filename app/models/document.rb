class Document < ActiveRecord::Base
  belongs_to :user

  attr_accessible :body, :title, :user_id
  
  validates :title, :body, :presence => true
end
