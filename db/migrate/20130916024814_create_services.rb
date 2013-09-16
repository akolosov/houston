class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :parent_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
