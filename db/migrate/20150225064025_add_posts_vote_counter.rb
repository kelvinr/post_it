class AddPostsVoteCounter < ActiveRecord::Migration
  def change
    add_column :posts, :vote_count, :integer, default: 1
  end
end
