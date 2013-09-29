class AddStateToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :state, :string
  end
end
