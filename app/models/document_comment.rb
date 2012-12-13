class DocumentComment < ActiveRecord::Base
  belongs_to :document
  belongs_to :comment
  # attr_accessible :title, :body
end
