class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.references :user

      t.timestamps
    end
    add_index :documents, :user_id
  end
end
