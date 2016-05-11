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

ActiveRecord::Schema.define(version: 20160510211515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charges", force: :cascade do |t|
    t.float    "amount"
    t.boolean  "refunded"
    t.string   "last_four"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "industry"
    t.string   "website"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interactions", force: :cascade do |t|
    t.integer  "user"
    t.string   "url"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.integer  "projectId"
    t.string   "title"
    t.string   "description"
    t.string   "filepath"
    t.string   "filetype"
    t.integer  "mediaTypeId"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "media_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "fromId"
    t.integer  "toId"
    t.integer  "projectId"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_status_types", force: :cascade do |t|
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "project_statuses", force: :cascade do |t|
    t.integer  "projectId"
    t.integer  "owner"
    t.integer  "statusId"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "customerId"
    t.integer  "affiliateId"
    t.string   "address"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "due"
    t.integer  "projectTypeId"
    t.integer  "owner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "referringUserId"
    t.integer  "referredUserId"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "zipCode"
    t.string   "email"
    t.string   "username"
    t.string   "password_enc"
    t.string   "password"
    t.string   "salt"
    t.integer  "userTypeId"
    t.integer  "active"
    t.integer  "approved"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "stripe_id"
    t.integer  "company_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.integer  "phoneType"
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
  end

end
