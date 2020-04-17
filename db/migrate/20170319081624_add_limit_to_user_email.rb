class AddLimitToUserEmail < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, limit: 100
  end
end
