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

ActiveRecord::Schema.define(version: 20150524222052) do

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

  create_table "entry_points", force: true do |t|
    t.integer "profile_id"
    t.date    "day"
    t.integer "period"
    t.string  "start"
    t.string  "end"
    t.integer "count"
    t.integer "int_day"
    t.date    "date"
    t.integer "ptNum"
  end

  add_index "entry_points", ["profile_id"], name: "index_entry_points_on_profile_id", using: :btree

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

  create_table "sales_slips", force: true do |t|
    t.integer  "profile_id"
    t.float    "total_sales"
    t.float    "farm_sales"
    t.float    "value_sales"
    t.float    "ready_sales"
    t.float    "WIC_FMNP_sales"
    t.float    "WIC_sales"
    t.float    "Senior_FMNP_sales"
    t.float    "Debt_sales"
    t.float    "SNAP_sales"
    t.float    "SNAP_transactions"
    t.float    "pounds_donated"
    t.float    "values_donated"
    t.string   "veg1"
    t.string   "veg2"
    t.string   "veg3"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales_slips", ["profile_id"], name: "index_sales_slips_on_profile_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "pass"
    t.string   "salt"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

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
    t.date     "date"
    t.text     "home_zip"
    t.integer  "yes28"
    t.integer  "no28"
    t.integer  "yes13"
    t.integer  "no13"
    t.integer  "yes36"
    t.integer  "no36"
    t.integer  "yes7"
    t.integer  "no7"
    t.integer  "Watermelons",              default: 0
    t.integer  "Wineberries",              default: 0
    t.integer  "PawPaws",                  default: 0
    t.integer  "Peaches",                  default: 0
    t.integer  "Pears",                    default: 0
    t.integer  "Plums",                    default: 0
    t.integer  "Quince",                   default: 0
    t.integer  "Raspberries",              default: 0
    t.integer  "Strawberries",             default: 0
    t.integer  "Tangerines",               default: 0
    t.integer  "Tayberries",               default: 0
    t.integer  "Kumquats",                 default: 0
    t.integer  "Lemons",                   default: 0
    t.integer  "Limes",                    default: 0
    t.integer  "Mulberries",               default: 0
    t.integer  "Oranges",                  default: 0
    t.integer  "Fejioas",                  default: 0
    t.integer  "Figs",                     default: 0
    t.integer  "Gooseberries",             default: 0
    t.integer  "Grapefruit",               default: 0
    t.integer  "Grapes",                   default: 0
    t.integer  "Honeydew_melons",          default: 0
    t.integer  "Apricots",                 default: 0
    t.integer  "Apriums",                  default: 0
    t.integer  "Asian_pears",              default: 0
    t.integer  "Avocados",                 default: 0
    t.integer  "Blackberries",             default: 0
    t.integer  "Blueberries",              default: 0
    t.integer  "Boysenberries",            default: 0
    t.integer  "Canary_melons",            default: 0
    t.integer  "Cantaloupes",              default: 0
    t.integer  "Cherimoyas",               default: 0
    t.integer  "Cherries",                 default: 0
    t.integer  "Chestnuts",                default: 0
    t.integer  "Currants",                 default: 0
    t.integer  "Dates",                    default: 0
    t.integer  "Artichokes",               default: 0
    t.integer  "Arugula",                  default: 0
    t.integer  "Asparagus",                default: 0
    t.integer  "Beets",                    default: 0
    t.integer  "Beet_greens",              default: 0
    t.integer  "Bok_choy",                 default: 0
    t.integer  "Broccoli",                 default: 0
    t.integer  "Broccoli_rabe",            default: 0
    t.integer  "Brussels_sprouts",         default: 0
    t.integer  "Cabbage",                  default: 0
    t.integer  "Cardoons",                 default: 0
    t.integer  "Carrots",                  default: 0
    t.integer  "Cauliflower",              default: 0
    t.integer  "Celeriac",                 default: 0
    t.integer  "Celery",                   default: 0
    t.integer  "Chard",                    default: 0
    t.integer  "Chicory",                  default: 0
    t.integer  "Chipilín",                 default: 0
    t.integer  "Collards",                 default: 0
    t.integer  "Cress",                    default: 0
    t.integer  "Cucumbers",                default: 0
    t.integer  "Dandelion_greens",         default: 0
    t.integer  "Dry_beans",                default: 0
    t.integer  "Eggplant",                 default: 0
    t.integer  "Fennel",                   default: 0
    t.integer  "Garlic_bulb",              default: 0
    t.integer  "Garlic_scapes",            default: 0
    t.integer  "Green_beans",              default: 0
    t.integer  "Herbs_fresh",              default: 0
    t.integer  "Hierbamora",               default: 0
    t.integer  "Horseradish",              default: 0
    t.integer  "Jicama",                   default: 0
    t.integer  "Kale",                     default: 0
    t.integer  "Kohlrabi",                 default: 0
    t.integer  "Lambs_quarters",           default: 0
    t.integer  "Leeks",                    default: 0
    t.integer  "Lettuce",                  default: 0
    t.integer  "Lima_Beans",               default: 0
    t.integer  "Mushrooms",                default: 0
    t.integer  "Mustard_greens",           default: 0
    t.integer  "Okra",                     default: 0
    t.integer  "Onions",                   default: 0
    t.integer  "Parsnips",                 default: 0
    t.integer  "Peas",                     default: 0
    t.integer  "Pea_shoots",               default: 0
    t.integer  "Peppers_hot",              default: 0
    t.integer  "Peppers_sweet",            default: 0
    t.integer  "Pumpkins",                 default: 0
    t.integer  "Potatoes",                 default: 0
    t.integer  "Purslane",                 default: 0
    t.integer  "Squash_summer",            default: 0
    t.integer  "Squash_winter",            default: 0
    t.integer  "Radishes",                 default: 0
    t.integer  "Rhubarb",                  default: 0
    t.integer  "Rutabagas",                default: 0
    t.integer  "Salsify",                  default: 0
    t.integer  "Scallions",                default: 0
    t.integer  "Shallots",                 default: 0
    t.integer  "Spinach",                  default: 0
    t.integer  "Sprouts",                  default: 0
    t.integer  "Sunchokes",                default: 0
    t.integer  "Sweet_corn",               default: 0
    t.integer  "Sweet_potatoes",           default: 0
    t.integer  "Sweet_potato",             default: 0
    t.integer  "Tomatillos",               default: 0
    t.integer  "Tomatoes",                 default: 0
    t.integer  "Turnips",                  default: 0
    t.integer  "Turnip_greens",            default: 0
    t.integer  "Yacon",                    default: 0
    t.integer  "Fava_beans",               default: 0
    t.integer  "Jujubes",                  default: 0
    t.integer  "Apples",                   default: 0
  end

  add_index "visitor_surveys", ["profile_id"], name: "index_visitor_surveys_on_profile_id", using: :btree

end
