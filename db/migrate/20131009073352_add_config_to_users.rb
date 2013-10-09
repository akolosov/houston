class AddConfigToUsers < ActiveRecord::Migration
  def change
    add_column :users, :_config, :text
  end
end
