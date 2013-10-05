class AddAllAroundDayToServiceClasses < ActiveRecord::Migration
  def change
    add_column :service_classes, :all_around_day, :boolean
  end
end
