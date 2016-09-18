class AddPostToComments < ActiveRecord::Migration
  def change
    add_column :comments, :to_post, :integer, index: true
  end
end
