class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :posts, :integer, default: 0
    change_column :users, :karma, :integer, default: 0
    change_column :users, :status_commentor, :boolean, default: true
    change_column :users, :status_moderator, :boolean, default: false
    change_column :users, :status_writer, :boolean, default: false
    change_column :users, :status_admin, :boolean, default: false 
  end
end
