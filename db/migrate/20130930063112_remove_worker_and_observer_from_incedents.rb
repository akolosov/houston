class RemoveWorkerAndObserverFromIncedents < ActiveRecord::Migration
  def up
    remove_column :incedents, :worker_id
    remove_column :incedents, :observer_id
  end

  def down
    add_column :incedents, :observer_id, :integer
    add_column :incedents, :worker_id, :integer
  end
end
