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

ActiveRecord::Schema.define(version: 20150921002044) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "share_name"
    t.string   "share_university"
    t.string   "summary"
    t.text     "contents"
    t.string   "my_image"
    t.string   "contact"
    t.string   "address"
    t.string   "main_menu"
    t.integer  "score",            default: 0
    t.integer  "numOfScore",       default: 0
    t.integer  "like",             default: 0
    t.boolean  "fame",             default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "replies", force: :cascade do |t|
    t.string   "writer"
    t.string   "writer_email"
    t.integer  "article_id"
    t.string   "contents"
    t.integer  "score",        default: 0
    t.integer  "like",         default: 0
    t.boolean  "fame",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "replystatuses", force: :cascade do |t|
    t.integer  "reply_id"
    t.integer  "user_id"
    t.integer  "share_count"
    t.integer  "evaluation_count"
    t.boolean  "liked",            default: false
    t.boolean  "selected",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "user_id"
    t.integer  "share_count"
    t.integer  "evaluation_count"
    t.boolean  "liked",            default: false
    t.boolean  "selected",         default: false
    t.boolean  "scored",           default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "univconfirms", force: :cascade do |t|
    t.string   "front_mail"
    t.string   "front_mail_code"
    t.string   "conf_code"
    t.string   "back_mail"
    t.string   "address_mail"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "university"
    t.integer  "confirm_check",          default: 0
    t.integer  "posting_check",          default: 0
    t.integer  "my_article_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
