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

ActiveRecord::Schema.define(version: 20160512193627) do

  create_table "event_commitments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "event_id",    limit: 4
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "event_commitments", ["user_id", "event_id"], name: "index_event_commitments_on_user_id_and_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_name",        limit: 50
    t.string   "location",          limit: 255
    t.text     "event_description", limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "category",          limit: 255
    t.integer  "creator_id",        limit: 4
    t.boolean  "visible",                         default: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.integer "event_id", limit: 4
  end

  add_index "events_users", ["user_id", "event_id"], name: "index_events_users_on_user_id_and_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 25
    t.string   "last_name",           limit: 50
    t.string   "email",               limit: 255,   default: "", null: false
    t.string   "password_digest",     limit: 255
    t.string   "major",               limit: 255
    t.text     "bio",                 limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "year",                limit: 255
  end

end
