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

ActiveRecord::Schema.define(version: 20140219150906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: true do |t|
    t.string  "unit"
    t.integer "user_id"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "number"
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.string  "address"
    t.string  "beds"
    t.string  "baths"
    t.string  "rent"
    t.text    "extras"
  end

  create_table "listings", force: true do |t|
    t.string  "url"
    t.integer "apartment_id"
  end

  create_table "reviews", force: true do |t|
    t.text     "review"
    t.datetime "datetime"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "apartment_id"
    t.string   "title"
  end

  create_table "users", force: true do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
  end

end
