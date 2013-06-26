class CreateServerAttaches < ActiveRecord::Migration
  def change
    create_table :server_attaches do |t|
      t.references :server
      t.references :attach

      t.timestamps
    end
    add_index :server_attaches, :server_id
    add_index :server_attaches, :attach_id
  end
end
