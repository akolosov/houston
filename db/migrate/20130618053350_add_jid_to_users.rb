class AddJidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :jabber, :string
  end
end
