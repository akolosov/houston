class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :server_categories, dependent: :destroy
  has_many :servers, through: :server_categories, dependent: :destroy

  validates :description, :name, presence: true
end
