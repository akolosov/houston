class CreateDocumentAttaches < ActiveRecord::Migration
  def change
    create_table :document_attaches do |t|
      t.references :document
      t.references :attach

      t.timestamps
    end
    add_index :document_attaches, :document_id
    add_index :document_attaches, :attach_id
  end
end
