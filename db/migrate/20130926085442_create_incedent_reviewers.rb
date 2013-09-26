class CreateIncedentReviewers < ActiveRecord::Migration
  def change
    create_table :incedent_reviewers do |t|
      t.references :incedent
      t.references :user
      t.datetime   :reviewed_at

      t.timestamps
    end
    add_index :incedent_reviewers, :incedent_id
    add_index :incedent_reviewers, :user_id
  end
end
