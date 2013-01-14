class CommentAttach < ActiveRecord::Base
  belongs_to :comment
  belongs_to :attach
  # attr_accessible :title, :body
end
