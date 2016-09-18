class AddCommentsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_on, :boolean, default: true
  end
end
