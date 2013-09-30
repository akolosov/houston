class CreateIncedentObservers < ActiveRecord::Migration
  def change
    create_table :incedent_observers do |t|
      t.references :incedent
      t.references :user

      t.timestamps
    end
    add_index :incedent_observers, :incedent_id
    add_index :incedent_observers, :user_id
  end
end
