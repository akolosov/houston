class Solution < ActiveRecord::Base
  resourcify

  belongs_to :command

  has_many :problem_solutions
  has_many :problems, :through => :problem_solutions

  attr_accessible :command_id, :command, :description, :name

  validates :name, :description, :presence => true

  def servers
  end

  def params
  end
end
