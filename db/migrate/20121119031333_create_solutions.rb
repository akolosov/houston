class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :name
      t.text :description
      t.references :problem
      t.references :command

      t.timestamps
    end
    add_index :solutions, :problem_id
    add_index :solutions, :command_id
  end
end
