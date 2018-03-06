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

ActiveRecord::Schema.define(version: 20180306041532) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

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
    t.boolean "validated", default: false
    t.string "job"
    t.boolean "rejected", default: false
    t.integer "admin_user_id"
    t.index ["admin_user_id"], name: "index_donators_on_admin_user_id"
    t.index ["slug"], name: "index_donators_on_slug", unique: true
  end

end
