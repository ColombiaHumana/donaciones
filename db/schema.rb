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

ActiveRecord::Schema.define(version: 20180221042104) do

  create_table "donations", force: :cascade do |t|
    t.string "epayco_ref"
    t.string "doctype"
    t.string "document"
    t.string "name"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "country"
    t.string "city"
    t.string "address"
    t.string "ip"
    t.float "amount"
    t.integer "transaction_id"
    t.datetime "transaction_date"
    t.integer "x_cod_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["epayco_ref"], name: "index_donations_on_epayco_ref"
  end

  create_table "donators", force: :cascade do |t|
    t.string "doctype"
    t.string "document"
    t.string "firstname"
    t.string "lastname"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rut_image_file_name"
    t.string "rut_image_content_type"
    t.integer "rut_image_file_size"
    t.datetime "rut_image_updated_at"
    t.string "doc_image_file_name"
    t.string "doc_image_content_type"
    t.integer "doc_image_file_size"
    t.datetime "doc_image_updated_at"
    t.string "slug"
    t.string "mobilephone"
    t.string "address"
    t.string "status", default: "PRE"
    t.boolean "payed", default: false
    t.string "email"
    t.string "x_ref_payco"
    t.string "x_transaction_id"
    t.string "x_signature"
    t.string "x_cod_response"
    t.string "x_approval_code"
    t.index ["slug"], name: "index_donators_on_slug", unique: true
  end

end
