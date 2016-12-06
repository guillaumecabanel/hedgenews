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

ActiveRecord::Schema.define(version: 20161205162812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "journalists", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "presentation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "scales", force: :cascade do |t|
    t.integer  "value"
    t.integer  "source_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_scales_on_category_id", using: :btree
    t.index ["source_id"], name: "index_scales_on_source_id", using: :btree
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.text     "presentation"
    t.string   "logo_url"
    t.string   "orientation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "scales", "categories"
  add_foreign_key "scales", "sources"
end
