class AddTreeToServices < ActiveRecord::Migration
  def change
    add_column :services, :lft, :integer
    add_column :services, :rgt, :integer
  end
end
