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

ActiveRecord::Schema.define(version: 2020_08_23_111153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "associateds", force: :cascade do |t|
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id"
    t.index ["document_id"], name: "index_associateds_on_document_id"
    t.index ["persona_id"], name: "index_associateds_on_persona_id"
  end

  create_table "comments", force: :cascade do |t|
    t.boolean "decision"
    t.string "observation"
    t.bigint "user_id"
    t.bigint "contract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_comments_on_contract_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.float "price", null: false
    t.datetime "validation", null: false
    t.datetime "expiration", null: false
    t.string "status", limit: 1, default: "E"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id"
    t.index ["document_id"], name: "index_contracts_on_document_id"
    t.index ["persona_id"], name: "index_contracts_on_persona_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "description"
    t.string "type_document"
    t.string "finality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "visibility_mode", limit: 1, default: "G"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_permissions_on_document_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "full_name"
    t.string "observation"
    t.string "identification"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "associateds", "documents"
  add_foreign_key "associateds", "personas"
  add_foreign_key "comments", "contracts"
  add_foreign_key "comments", "users"
  add_foreign_key "contracts", "documents"
  add_foreign_key "contracts", "personas"
  add_foreign_key "permissions", "documents"
  add_foreign_key "permissions", "users"
end
