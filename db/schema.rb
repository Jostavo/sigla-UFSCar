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

ActiveRecord::Schema.define(version: 20161117044145) do

  create_table "computer_statuses", force: :cascade do |t|
    t.string   "status"
    t.integer  "computer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["computer_id"], name: "index_computer_statuses_on_computer_id"
  end

  create_table "computers", force: :cascade do |t|
    t.integer  "laboratory_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "physical_id"
    t.string   "status"
    t.index ["laboratory_id"], name: "index_computers_on_laboratory_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string   "title"
    t.string   "mantainer"
    t.string   "email"
    t.string   "linkDocs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "initials"
    t.string   "function"
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "solution"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "computer_id"
    t.integer  "user_id"
    t.string   "laboratory_initials"
    t.integer  "laboratory_id"
    t.index ["computer_id"], name: "index_reports_on_computer_id"
    t.index ["laboratory_id"], name: "index_reports_on_laboratory_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.integer  "laboratory_id"
    t.boolean  "isOpen"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["laboratory_id"], name: "index_statuses_on_laboratory_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "laboratory_id"
    t.boolean  "isFreeToJoin"
    t.index ["laboratory_id"], name: "index_subjects_on_laboratory_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "name"
    t.string   "function",               default: "normal"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
