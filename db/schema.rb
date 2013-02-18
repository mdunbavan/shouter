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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130214194600) do

  create_table "follows", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "follow_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shouts", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "profile_bg"
    t.string   "profile_fg"
    t.string   "profile_image"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image_type"
  end

  create_table "users_shouts", :id => false, :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "shout_id", :null => false
  end

  add_index "users_shouts", ["user_id", "shout_id"], :name => "index_users_shouts_on_user_id_and_shout_id", :unique => true

end
