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

ActiveRecord::Schema.define(version: 20150315170757) do

  create_table "markets", force: true do |t|
    t.date     "start"
    t.date     "end"
    t.text     "market_type"
    t.integer  "profile_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "market_num"
  end

  add_index "markets", ["profile_id"], name: "index_markets_on_profile_id"

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "address"
    t.string   "county"
    t.integer  "year"
    t.boolean  "multiple_locs"
    t.boolean  "year_round"
    t.string   "host_name"
    t.string   "incorporated"
    t.boolean  "FMC_member"
    t.string   "other_associations"
    t.boolean  "mission_statement"
    t.boolean  "ms_website"
    t.boolean  "ms_manual"
    t.boolean  "ms_market_promos"
    t.boolean  "ms_none"
    t.boolean  "ms_other"
    t.string   "ms_other_text"
    t.date     "when_ms"
    t.string   "person_decisions"
    t.text     "list_of_persons"
    t.string   "logo_path"
    t.string   "city"
    t.string   "incorporated_other"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "pass"
    t.string   "salt"
  end

end
