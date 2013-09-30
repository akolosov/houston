class AddReviewToServiceClasses < ActiveRecord::Migration
  def change
    add_column :service_classes, :review, :boolean, default: false
  end
end
