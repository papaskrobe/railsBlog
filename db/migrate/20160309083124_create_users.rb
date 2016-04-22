class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :posts
      t.integer :karma
      t.datetime :last_karma
      t.text :signature
      t.boolean :status_commentor
      t.boolean :status_moderator
      t.boolean :status_writer
      t.boolean :status_admin

      t.timestamps null: false
    end
  end
end
