class CommentAttach < ActiveRecord::Base
  belongs_to :comment
  belongs_to :attach
  
  attr_accessible :attach_id, :comment_id, :comment, :attach

  before_destroy { |record| Attach.destroy_all "id = #{record.attach_id}" }

end
