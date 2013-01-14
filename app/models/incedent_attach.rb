class IncedentAttach < ActiveRecord::Base
  belongs_to :incedent
  belongs_to :attach
  # attr_accessible :title, :body
end
