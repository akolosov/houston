class Category < ActiveRecord::Base
  attr_accessible :description, :name, :servers, :server_ids

  has_many :server_categories
  has_many :servers, through: :server_categories, dependent: :delete_all

  validates :description, :name, presence: true
end
