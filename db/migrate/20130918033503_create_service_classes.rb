class CreateServiceClasses < ActiveRecord::Migration
  def change
    create_table :service_classes do |t|
      t.references :service
      t.references :type
      t.references :priority
      t.integer :reaction_hours
      t.boolean :autoclose
      t.integer :autoclose_hours
      t.integer :escalation_hours
      t.integer :performance_hours

      t.timestamps
    end
    add_index :service_classes, :service_id
    add_index :service_classes, :type_id
    add_index :service_classes, :priority_id
  end
end
