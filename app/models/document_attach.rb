class DocumentAttach < ActiveRecord::Base
  belongs_to :document
  belongs_to :attach
  
  attr_accessible :document_id, :attach_id
end
