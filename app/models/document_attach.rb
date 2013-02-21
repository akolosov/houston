class DocumentAttach < ActiveRecord::Base
  belongs_to :document
  belongs_to :attach
  
  before_destroy { |record| Attach.destroy_all "id = #{record.attach_id}" }

  attr_accessible :document_id, :attach_id, :document, :attach

end
