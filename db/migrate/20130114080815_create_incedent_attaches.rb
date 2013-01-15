class CreateIncedentAttaches < ActiveRecord::Migration
  def change
    create_table :incedent_attaches do |t|
      t.references :incedent
      t.references :attach

      t.timestamps
    end
    add_index :incedent_attaches, :incedent_id
    add_index :incedent_attaches, :attach_id
  end
end
