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

ActiveRecord::Schema.define(version: 20160404191452) do

# Could not dump table "datasets" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "records", force: :cascade do |t|
    t.string   "schema"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "uuid"
    t.string   "dc_identifier_s"
    t.string   "dc_title_s"
    t.text     "dc_description_s"
    t.string   "dc_rights_s"
    t.string   "dct_provenance_s"
    t.text     "dct_references_s"
    t.text     "georss_box_s"
    t.string   "layer_id_s"
    t.string   "layer_geom_type_s"
    t.datetime "layer_modified_dt"
    t.string   "layer_slug_s"
    t.text     "solr_geom"
    t.text     "solr_year_i"
    t.text     "dc_creator_sm"
    t.integer  "user_id"
    t.text     "georss_polygon_s"
    t.integer  "processor_count"
  end

  add_index "records", ["user_id", "created_at"], name: "index_records_on_user_id_and_created_at"
  add_index "records", ["user_id"], name: "index_records_on_user_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
