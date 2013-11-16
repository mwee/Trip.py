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

ActiveRecord::Schema.define(version: 20131116190847) do

  create_table "calendars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "dateranges", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "freeranges", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "trips", force: true do |t|
    t.string   "title"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "cost_min"
    t.float    "cost_max"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "creator_id"
  end

  create_table "trips_users", id: false, force: true do |t|
    t.integer "trip_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "destination"
    t.float    "budget_in_min"
    t.float    "budget_out_min"
    t.float    "budget_out_max"
    t.float    "budget_in_max"
  end

end
