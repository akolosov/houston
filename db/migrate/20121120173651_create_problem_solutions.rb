class CreateProblemSolutions < ActiveRecord::Migration
  def change
    create_table :problem_solutions do |t|
      t.references :problem
      t.references :solution
      t.string :params

      t.timestamps
    end
    add_index :problem_solutions, :problem_id
    add_index :problem_solutions, :solution_id
  end
end
