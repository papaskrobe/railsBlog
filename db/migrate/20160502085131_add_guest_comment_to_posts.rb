class AddGuestCommentToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :guest_comment, :boolean 
  end
end
