class AddIpToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ip_address, :string
  end
end
