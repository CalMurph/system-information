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

ActiveRecord::Schema[8.1].define(version: 2026_07_16_123524) do
  create_table "data", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "json"
    t.integer "sysinfo_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sysinfo_id"], name: "index_data_on_sysinfo_id"
  end

  create_table "jsons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "json"
    t.integer "sysinfo_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sysinfo_id"], name: "index_jsons_on_sysinfo_id"
  end

  create_table "sysinfos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "json"
    t.string "name"
    t.text "notes"
    t.string "rack_pos"
    t.string "slots"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "data", "sysinfos"
  add_foreign_key "jsons", "sysinfos"
end
