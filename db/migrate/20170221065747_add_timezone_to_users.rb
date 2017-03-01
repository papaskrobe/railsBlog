class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :integer, :default => 0
  end
end
