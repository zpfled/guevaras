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

ActiveRecord::Schema.define(version: 20160423212040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_item_drafts", force: :cascade do |t|
    t.text     "description"
    t.string   "name"
    t.integer  "phone_number"
    t.float    "price"
    t.integer  "category_id"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string  "name",        limit: 50, null: false
    t.text    "description",            null: false
    t.integer "price",                  null: false
    t.integer "category_id"
    t.integer "menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.integer "id",                   default: "nextval('users_id_seq'::regclass)", null: false
    t.text    "name",                                                               null: false
    t.text    "email",                                                              null: false
    t.string  "password", limit: 255,                                               null: false
    t.boolean "admin",                default: false
  end

  add_index "users", ["email"], name: "unique_users_email", unique: true, using: :btree
  add_index "users", ["id"], name: "unique_users_key", unique: true, using: :btree
  add_index "users", ["name"], name: "unique_users_name", unique: true, using: :btree

end
