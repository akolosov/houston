class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :author
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :comments, :author_id
  end
end
