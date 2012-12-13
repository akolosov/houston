class CreateDocumentComments < ActiveRecord::Migration
  def change
    create_table :document_comments do |t|
      t.references :document
      t.references :comment

      t.timestamps
    end
    add_index :document_comments, :document_id
    add_index :document_comments, :comment_id
  end
end
