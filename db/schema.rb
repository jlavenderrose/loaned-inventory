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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130612061535) do

  create_table "administrators", :force => true do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "audit_log_entries", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inventory_loans", :force => true do |t|
    t.date     "loaned_date"
    t.date     "returned_date"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "inventory_object_id"
    t.integer  "loanee"
  end

  create_table "inventory_object_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inventory_object_versions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "inventory_object_type_id"
  end

  create_table "inventory_objects", :force => true do |t|
    t.string   "id1"
    t.string   "id2"
    t.string   "id3"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "inventory_object_type_id"
    t.integer  "inventory_object_version_id"
  end

  create_table "loanees", :force => true do |t|
    t.string   "fullname"
    t.string   "idnum"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "report_entries", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "report_entry_objects", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
