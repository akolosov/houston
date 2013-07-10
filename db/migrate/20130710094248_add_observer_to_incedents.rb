class AddObserverToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :observer_id, :integer
  end
end
