class ServerCategory < ActiveRecord::Base
  belongs_to :server
  belongs_to :category

  attr_accessible :category_id, :server_id, :server, :category

end
