class RemoveContentWipFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :content_wip, :text
    remove_column :posts, :updated, :datetime

  end
end
