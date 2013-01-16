class CommentAttach < ActiveRecord::Base
  belongs_to :comment
  belongs_to :attach
  
  attr_accessible :attach_id, :comment_id, :comment, :attach
end
