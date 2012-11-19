class Solution < ActiveRecord::Base
  belongs_to :problem
  belongs_to :command

  attr_accessible :problem_id, :command_id, :description, :name

  validates :problem, :presence => true
end
