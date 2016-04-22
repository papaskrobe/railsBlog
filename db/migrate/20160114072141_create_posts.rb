class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.text :content_wip
      t.text :content_final
      t.datetime :posted
      t.datetime :updated
      t.integer :views

      t.timestamps null: false
    end
  add_index :posts, :posted
  add_index :posts, :url

  end
end
