class CreateProblemTags < ActiveRecord::Migration
  def change
    create_table :problem_tags do |t|
      t.references :tag
      t.references :problem

      t.timestamps
    end
    add_index :problem_tags, :tag_id
    add_index :problem_tags, :problem_id
  end
end
