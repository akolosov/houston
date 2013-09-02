class AddFinishToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :finish_at, :datetime, default: 'now'
  end
end
