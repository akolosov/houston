class Solution < ActiveRecord::Base
  resourcify

  belongs_to :problem
  belongs_to :command

  attr_accessible :problem_id, :command_id, :problem, :command, :description, :name

  validates :problem, :presence => true

  def servers
  end

  def params
  end
end
