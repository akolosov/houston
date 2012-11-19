class CreateServerProblems < ActiveRecord::Migration
  def change
    create_table :server_problems do |t|
      t.references :server
      t.references :problem

      t.timestamps
    end
    add_index :server_problems, :server_id
    add_index :server_problems, :problem_id
  end
end
