class Division < ActiveRecord::Base
  resourcify

  attr_accessible :description, :name, :users, :user_ids

  has_many :users
  has_many :services

  validates :description, :name, presence: true
end
