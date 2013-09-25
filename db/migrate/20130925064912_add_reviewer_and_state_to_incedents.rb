class AddReviewerAndStateToIncedents < ActiveRecord::Migration
  def change
    add_column :incedents, :reviewer_id, :integer
    add_column :incedents, :state, :string
    add_column :incedents, :reviewed_at, :datetime
  end
end
