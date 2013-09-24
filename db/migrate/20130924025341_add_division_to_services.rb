class AddDivisionToServices < ActiveRecord::Migration
  def change
    add_column :services, :division_id, :integer
  end
end
