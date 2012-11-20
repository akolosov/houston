class Problem < ActiveRecord::Base
  resourcify

  attr_accessible :description, :name

  validates :name, :description, :presence => true

  has_many :solutions

  has_many :server_problems
  has_many :servers, :through => :server_problems

  def commands
  end
end
