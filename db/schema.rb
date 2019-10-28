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

ActiveRecord::Schema.define(version: 2019_10_28_082818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "genre"
    t.string "platform"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.integer "price"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_listings_on_game_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "customer_id_id"
    t.integer "rental_fee"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id_id"], name: "index_rentals_on_customer_id_id"
    t.index ["listing_id"], name: "index_rentals_on_listing_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "rental_id"
    t.integer "rating"
    t.text "review_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rental_id"], name: "index_reviews_on_rental_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.text "profile_info"
    t.string "photo"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "listings", "games"
  add_foreign_key "listings", "users"
  add_foreign_key "rentals", "listings"
  add_foreign_key "rentals", "users", column: "customer_id_id"
  add_foreign_key "reviews", "rentals"
end
