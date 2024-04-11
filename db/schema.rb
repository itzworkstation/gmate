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

ActiveRecord::Schema[7.0].define(version: 2024_04_05_170418) do
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
    t.integer "used_in_days", default: 1
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
    t.index ["brand_id"], name: "index_store_archived_products_on_brand_id"
    t.index ["product_id"], name: "index_store_archived_products_on_product_id"
    t.index ["store_id"], name: "index_store_archived_products_on_store_id"
  end

  create_table "store_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "store_id", null: false
    t.integer "used_in_days", default: 2
    t.integer "state", default: 0
    t.datetime "opened_at"
    t.integer "measurement"
    t.integer "measurement_unit"
    t.integer "measurement_unit_count", default: 1
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "store_archived_products", "products"
  add_foreign_key "store_archived_products", "stores"
  add_foreign_key "store_products", "products"
  add_foreign_key "store_products", "stores"
end
