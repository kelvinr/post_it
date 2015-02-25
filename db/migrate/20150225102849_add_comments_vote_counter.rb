class AddCommentsVoteCounter < ActiveRecord::Migration
  def change
    add_column :comments, :vote_count, :integer, default: 1
  end
end
