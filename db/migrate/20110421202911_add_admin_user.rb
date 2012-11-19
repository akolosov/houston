class AddAdminUser < ActiveRecord::Migration
  def self.up
    add_column :users, :session, :string
  end

  def self.down
    remove_column :users, :session
  end
end
