# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_18_101404) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "show_id"
    t.integer "seats", default: [], array: true
    t.index ["show_id"], name: "index_bookings_on_show_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "action"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "genre"
    t.date "release_date"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "bookings_id", null: false
    t.decimal "payment"
    t.boolean "status"
    t.string "payment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookings_id"], name: "index_payments_on_bookings_id"
  end

  create_table "screens", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "theater_id", null: false
    t.integer "number_of_seats"
    t.boolean "active"
    t.index ["theater_id"], name: "index_screens_on_theater_id"
  end

  create_table "shows", force: :cascade do |t|
    t.bigint "screen_id", null: false
    t.bigint "movie_id", null: false
    t.date "show_date"
    t.time "show_time"
    t.decimal "ticket_price_ordinary"
    t.decimal "ticket_price_premium"
    t.integer "booked_tickets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["screen_id"], name: "index_shows_on_screen_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "theater_name"
    t.string "theater_address"
    t.string "pincode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.boolean "active"
    t.index ["location_id"], name: "index_theaters_on_location_id"
    t.index ["user_id"], name: "index_theaters_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.boolean "active"
  end

  add_foreign_key "bookings", "shows"
  add_foreign_key "bookings", "users"
  add_foreign_key "payments", "bookings", column: "bookings_id"
  add_foreign_key "screens", "theaters"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "screens"
  add_foreign_key "theaters", "locations"
  add_foreign_key "theaters", "users"
end