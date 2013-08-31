class AddFirstLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_login, :boolean, default: true
  end
end
