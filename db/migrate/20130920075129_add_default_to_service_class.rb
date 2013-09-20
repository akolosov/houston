class AddDefaultToServiceClass < ActiveRecord::Migration
  def change
    add_column :service_classes, :is_default, :boolean, default: false
  end
end
