class CreateIncedents < ActiveRecord::Migration
  def change
    create_table :incedents do |t|
      t.string :name
      t.text :description
      t.references :initiator
      t.references :worker
      t.references :status
      t.references :priority
      t.references :type

      t.timestamps
    end
    add_index :incedents, :initiator_id
    add_index :incedents, :worker_id
    add_index :incedents, :status_id
    add_index :incedents, :priority_id
    add_index :incedents, :type_id
  end
end
