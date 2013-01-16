class DocumentComment < ActiveRecord::Base
  belongs_to :document
  belongs_to :comment

  attr_accessible :document_id, :comment_id, :comment, :document
end
