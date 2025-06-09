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

ActiveRecord::Schema[8.0].define(version: 2025_06_09_052650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "stock_state", ["out_of_stock", "in_stock", "to_order", "sold_out"]

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.integer "pages"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magazines", force: :cascade do |t|
    t.string "name", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.jsonb "decription"
    t.string "productable_type"
    t.integer "productable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "state", enum_type: "stock_state"
    t.index ["state"], name: "index_products_on_state"
  end

  create_table "storage_items", force: :cascade do |t|
    t.decimal "cost", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "shipping", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "price", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "quantity", default: 0, null: false
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_storage_items_on_product_id"
  end
end
