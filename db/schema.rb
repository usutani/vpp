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

ActiveRecord::Schema.define(version: 20140319002456) do

  create_table "licenses", force: true do |t|
    t.integer  "license_id"
    t.integer  "user_id"
    t.integer  "adam_id"
    t.integer  "product_type_id"
    t.string   "its_id_hash"
    t.string   "pricing_param"
    t.string   "status"
    t.string   "product_type_name"
    t.boolean  "is_irrevocable"
    t.string   "client_user_id_str"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "client_user_id_str"
    t.string   "email"
    t.string   "its_id_hash"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invite_url"
    t.string   "invite_code"
  end

end
