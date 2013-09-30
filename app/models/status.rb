class Status < ActiveRecord::Base
  attr_accessible :name

  has_many :incedents
  has_many :incedent_workers

end
