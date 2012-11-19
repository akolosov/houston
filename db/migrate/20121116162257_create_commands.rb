class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :name
      t.text :description
      t.string :command
      t.boolean :with_params
      t.boolean :confirm

      t.timestamps
    end
  end
end
