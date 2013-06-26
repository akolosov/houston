class ServerAttach < ActiveRecord::Base
  belongs_to :server
  belongs_to :attach

  attr_accessible :attach_id, :server_id, :server, :attach

  before_destroy { |record| Attach.destroy_all "id = #{record.attach_id}" }

end
