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

ActiveRecord::Schema.define(version: 20150406005426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessibilities", force: true do |t|
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bus_sub"
    t.boolean  "bike_racks"
    t.boolean  "sidewalks"
    t.boolean  "free_parking"
    t.boolean  "roof"
    t.boolean  "other_access"
    t.string   "other_access_explain"
    t.string   "selling_space"
    t.boolean  "children_activities"
    t.boolean  "live_music"
    t.boolean  "food_demonstrations"
    t.boolean  "restrooms"
    t.integer  "restroom_count"
    t.boolean  "accept_SNAP"
    t.string   "SNAP_offer"
    t.boolean  "FMNP_available"
    t.boolean  "accept_FMNP"
    t.string   "FMNP_offer"
    t.boolean  "FMNP_senior_available"
    t.boolean  "accept_FMNP_senior"
    t.string   "FMNP_senior_offer"
    t.boolean  "CVV_available"
    t.boolean  "accept_CVV"
    t.string   "CVV_offer"
    t.boolean  "other_vouchers"
    t.text     "other_vouchers_explain"
  end

  add_index "accessibilities", ["profile_id"], name: "index_accessibilities_on_profile_id", using: :btree

  create_table "managements", force: true do |t|
    t.integer "num_staff"
    t.integer "positions"
    t.string  "other"
    t.integer "ave_unpaid_market"
    t.integer "ave_unpaid_non_market"
    t.integer "ave_paid_market"
    t.integer "ave_paid_non_market"
    t.float   "annual_budget_for_staff"
    t.float   "annual_operating_budget"
    t.string  "bookKeeper"
    t.boolean "other_rules"
    t.string  "other_rules_path"
    t.float   "annual_application_fee"
    t.float   "annual_membership_fee"
    t.float   "percentage_sales"
    t.float   "no_charge"
    t.float   "other_charge"
    t.string  "other_charge_explained"
    t.integer "ave_num_vendors"
    t.integer "profile_id"
  end

  add_index "managements", ["profile_id"], name: "index_managements_on_profile_id", using: :btree

  create_table "markets", force: true do |t|
    t.date     "start"
    t.date     "end"
    t.text     "market_type"
    t.integer  "profile_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "market_num"
  end

  add_index "markets", ["profile_id"], name: "index_markets_on_profile_id", using: :btree

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

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

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
