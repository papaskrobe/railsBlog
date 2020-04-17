class AddLimitToPostLength < ActiveRecord::Migration
  def change
    change_column :posts, :url, :string, limit: 100
  end
end
