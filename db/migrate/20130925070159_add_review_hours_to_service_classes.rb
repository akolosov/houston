class AddReviewHoursToServiceClasses < ActiveRecord::Migration
  def change
    add_column :service_classes, :review_hours, :integer
  end
end
