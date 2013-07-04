class AddServerToIncedent < ActiveRecord::Migration
  def change
    add_column :incedents, :server_id, :integer
  end
end
