# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_08_184112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.string "email"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "otp_secret_key"
    t.string "reference_code"
    t.integer "referred_by_id"
    t.string "language", default: "en"
    t.index ["reference_code"], name: "index_accounts_on_reference_code"
    t.index ["referred_by_id"], name: "index_accounts_on_referred_by_id"
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brand_sub_categories", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "sub_category_id", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_sub_categories_on_brand_id"
    t.index ["sub_category_id"], name: "index_brand_sub_categories_on_sub_category_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "is_active", default: true
    t.bigint "sub_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
  end

  create_table "store_archived_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "store_id", null: false
    t.integer "days_to_consume", default: 1
    t.integer "actual_used_in_days", default: 10
    t.integer "state", default: 0
    t.integer "measurement"
    t.datetime "used_at"
    t.integer "measurement_unit"
    t.integer "measurement_unit_count", default: 1
    t.boolean "is_pack", default: true
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiry_date"
    t.decimal "price", precision: 7, scale: 2
    t.datetime "start_to_consume"
    t.index ["brand_id"], name: "index_store_archived_products_on_brand_id"
    t.index ["product_id"], name: "index_store_archived_products_on_product_id"
    t.index ["store_id"], name: "index_store_archived_products_on_store_id"
  end

  create_table "store_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "store_id", null: false
    t.integer "days_to_consume", default: 2
    t.integer "state", default: 0
    t.datetime "start_to_consume"
    t.integer "measurement"
    t.integer "measurement_unit"
    t.integer "measurement_unit_count", default: 1
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiry_date"
    t.decimal "price", precision: 7, scale: 2
    t.index ["brand_id"], name: "index_store_products_on_brand_id"
    t.index ["product_id"], name: "index_store_products_on_product_id"
    t.index ["store_id"], name: "index_store_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: true
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "products_count", default: 0, null: false
    t.index ["account_id"], name: "index_stores_on_account_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "is_active", default: true
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "brand_sub_categories", "brands"
  add_foreign_key "brand_sub_categories", "sub_categories"
  add_foreign_key "store_archived_products", "products"
  add_foreign_key "store_archived_products", "stores"
  add_foreign_key "store_products", "products"
  add_foreign_key "store_products", "stores"
end
