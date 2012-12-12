class CreateIncedentTags < ActiveRecord::Migration
  def change
    create_table :incedent_tags do |t|
      t.references :tag
      t.references :incedent

      t.timestamps
    end
    add_index :incedent_tags, :tag_id
    add_index :incedent_tags, :incedent_id
  end
end
