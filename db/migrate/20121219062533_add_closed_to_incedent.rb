class AddClosedToIncedent < ActiveRecord::Migration
  def change
    add_column :incedents, :closed, :boolean, default: false
  end
end
