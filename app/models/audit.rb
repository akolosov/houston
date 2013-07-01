class Audit < ActiveRecord::Base
  belongs_to :user

  def self.search(query)
    where("audited_changes like '%#{query}%' or comment like '%#{query}%'")
  end

end