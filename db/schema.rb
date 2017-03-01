# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170228074539) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "response_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "to_post"
    t.string   "ip_address"
  end

  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content_final"
    t.datetime "posted"
    t.integer  "views"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "guest_comment"
    t.boolean  "comments_on",   default: true
  end

  add_index "posts", ["posted"], name: "index_posts_on_posted"
  add_index "posts", ["url"], name: "index_posts_on_url"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "posts",            default: 0
    t.integer  "karma",            default: 0
    t.datetime "last_karma"
    t.text     "signature"
    t.boolean  "status_commentor", default: true
    t.boolean  "status_moderator", default: false
    t.boolean  "status_writer",    default: false
    t.boolean  "status_admin",     default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "remember_digest"
    t.integer  "time_zone",        default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
