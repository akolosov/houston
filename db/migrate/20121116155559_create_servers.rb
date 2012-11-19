class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :address
      t.string :username

      t.timestamps
    end
  end
end
