class AddParentToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :parent_id, :integer
    add_column :incedents, :lft, :integer
    add_column :incedents, :rgt, :integer
  end
end
