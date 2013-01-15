class CreateAttaches < ActiveRecord::Migration
  def change
    create_table :attaches do |t|
      t.string :name
      t.text :description
      t.string :mime
      t.integer :size

      t.timestamps
    end
  end
end
