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

ActiveRecord::Schema.define(version: 20150421210002) do

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
    t.string   "other_access_features_explain"
    t.string   "SNAP_offer_other"
    t.string   "FMNP_offer_other"
    t.string   "FMNP_senior_offer_other"
    t.string   "CVV_offer_other"
    t.boolean  "other_features"
    t.string   "other_features_explain"
  end

  add_index "accessibilities", ["profile_id"], name: "index_accessibilities_on_profile_id", using: :btree

  create_table "communities", force: true do |t|
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "customers"
    t.boolean  "municipal"
    t.boolean  "producers"
    t.boolean  "extension"
    t.boolean  "community_groups"
    t.boolean  "advisors_other"
    t.text     "sponsors"
    t.boolean  "newsletter"
    t.boolean  "facebook"
    t.boolean  "twitter"
    t.boolean  "google"
    t.boolean  "pinterest"
    t.boolean  "online_other"
    t.string   "online_other_explain"
    t.boolean  "annual_report"
    t.string   "report_link"
    t.boolean  "experience_collecting"
    t.text     "resources_available"
    t.boolean  "advisors_other_explain"
  end

  add_index "communities", ["profile_id"], name: "index_communities_on_profile_id", using: :btree

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

  create_table "metrics", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.string   "text4"
    t.string   "date1"
    t.string   "date2"
    t.string   "date3"
    t.string   "date4"
    t.string   "check1"
    t.string   "check2"
    t.string   "check3"
    t.string   "check4"
    t.text     "check1Opts"
    t.text     "check2Opts"
    t.text     "check3Opts"
    t.text     "check4Opts"
    t.string   "radio1"
    t.string   "radio2"
    t.string   "radio3"
    t.string   "radio4"
    t.text     "radio1Opts"
    t.text     "radio2Opts"
    t.text     "radio3Opts"
    t.text     "radio4Opts"
    t.string   "select1"
    t.string   "select2"
    t.string   "select3"
    t.string   "select4"
    t.text     "select1Opts"
    t.text     "select2Opts"
    t.text     "select3Opts"
    t.text     "select4Opts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "metrics_1"
    t.integer  "metrics_2"
    t.string   "zip"
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
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vc_entries", force: true do |t|
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vc_entries", ["profile_id"], name: "index_vc_entries_on_profile_id", using: :btree

  create_table "visitor_surveys", force: true do |t|
    t.integer  "profile_id"
    t.integer  "bikes"
    t.integer  "walking"
    t.integer  "bus"
    t.integer  "taxi"
    t.integer  "other_method"
    t.integer  "every_week"
    t.integer  "every_other_week"
    t.integer  "every_month"
    t.integer  "less_than_month"
    t.float    "spent_morning"
    t.float    "spent_afternoon"
    t.float    "downtown_spent_morning"
    t.float    "downtown_spent_afternoon"
    t.integer  "lettuces"
    t.integer  "roots"
    t.integer  "tomatoes"
    t.integer  "corn"
    t.integer  "melons"
    t.integer  "berries"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visitor_surveys", ["profile_id"], name: "index_visitor_surveys_on_profile_id", using: :btree

  create_table "vistor_surveys", force: true do |t|
    t.integer  "profile_id"
    t.boolean  "other_activities"
    t.boolean  "morning_activities"
    t.float    "money_activities"
    t.float    "money_market"
    t.boolean  "morning_market"
    t.boolean  "first_time"
    t.string   "frequency"
    t.boolean  "personal_vehicle"
    t.string   "vehicle"
    t.string   "home_zip"
    t.boolean  "fruits"
    t.string   "fruit1"
    t.string   "fruit2"
    t.string   "fruit3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vistor_surveys", ["profile_id"], name: "index_vistor_surveys_on_profile_id", using: :btree

end
