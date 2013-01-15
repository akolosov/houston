class CreateCommentAttaches < ActiveRecord::Migration
  def change
    create_table :comment_attaches do |t|
      t.references :comment
      t.references :attach

      t.timestamps
    end
    add_index :comment_attaches, :comment_id
    add_index :comment_attaches, :attach_id
  end
end
