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

ActiveRecord::Schema.define(version: 20140717221546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_forecasts", force: true do |t|
    t.integer  "temperature"
    t.string   "condition"
    t.string   "wind_speed"
    t.integer  "humidity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day_forecasts", force: true do |t|
    t.string   "day",            limit: 20
    t.integer  "high"
    t.integer  "low"
    t.string   "day_details",    limit: 500
    t.string   "night_details",  limit: 500
    t.boolean  "day_recorded"
    t.boolean  "night_recorded"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hour_forecasts", force: true do |t|
    t.datetime "time"
    t.integer  "temperature"
    t.integer  "wind"
    t.decimal  "precipitation"
    t.decimal  "humidity"
    t.decimal  "sky_cover"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
