class CreateIncedentActions < ActiveRecord::Migration
  def change
    create_table :incedent_actions do |t|
      t.references :incedent
      t.references :status
      t.references :worker

      t.timestamps
    end

    add_index :incedent_actions, :incedent_id
    add_index :incedent_actions, :status_id
    add_index :incedent_actions, :worker_id
  end
end
