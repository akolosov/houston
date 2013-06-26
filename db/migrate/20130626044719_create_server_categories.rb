class CreateServerCategories < ActiveRecord::Migration
  def change
    create_table :server_categories do |t|
      t.references :server
      t.references :category

      t.timestamps
    end
    add_index :server_categories, :server_id
    add_index :server_categories, :category_id
  end
end
