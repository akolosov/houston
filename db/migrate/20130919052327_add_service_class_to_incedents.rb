class AddServiceClassToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :service_class_id, :integer
  end
end
