class AddOperatorToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :operator_id, :integer
  end
end
