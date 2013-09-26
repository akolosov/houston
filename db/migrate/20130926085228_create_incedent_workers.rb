class CreateIncedentWorkers < ActiveRecord::Migration
  def change
    create_table :incedent_workers do |t|
      t.references :incedent
      t.references :user
      t.references :status

      t.timestamps
    end
    add_index :incedent_workers, :incedent_id
    add_index :incedent_workers, :user_id
    add_index :incedent_workers, :status_id
  end
end
