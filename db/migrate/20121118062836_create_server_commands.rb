class CreateServerCommands < ActiveRecord::Migration
  def change
    create_table :server_commands do |t|
      t.references :server
      t.references :command
      t.string :params

      t.timestamps
    end
    add_index :server_commands, :server_id
    add_index :server_commands, :command_id
  end
end
