class CreateIncedentComments < ActiveRecord::Migration
  def change
    create_table :incedent_comments do |t|
      t.references :incedent
      t.references :comment

      t.timestamps
    end
    add_index :incedent_comments, :incedent_id
    add_index :incedent_comments, :comment_id
  end
end
