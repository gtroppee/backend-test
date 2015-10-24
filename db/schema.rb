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

ActiveRecord::Schema.define(version: 20151024122841) do

  create_table "calls", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "answered_at"
    t.string   "direction"
    t.integer  "duration",      default: 0
    t.string   "status"
    t.string   "uid"
    t.float    "cost",          default: 0.0
    t.float    "rate"
    t.string   "caller_sip"
    t.string   "recipient_sip"
    t.string   "caller_name"
    t.text     "record_url"
    t.integer  "record_length"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_number_assignments", force: :cascade do |t|
    t.string   "callable_type",   null: false
    t.integer  "callable_id",     null: false
    t.integer  "phone_number_id"
    t.integer  "priority",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "phone_number_assignments", ["callable_id"], name: "index_phone_number_assignments_on_callable_id"
  add_index "phone_number_assignments", ["callable_type"], name: "index_phone_number_assignments_on_callable_type"
  add_index "phone_number_assignments", ["phone_number_id"], name: "index_phone_number_assignments_on_phone_number_id"

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "sip_endpoint"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"

end
