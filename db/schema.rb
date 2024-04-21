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

ActiveRecord::Schema[7.0].define(version: 2024_04_21_150639) do
  create_table "categories", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prompts", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.string "nick_name", null: false
    t.integer "ai_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_md5_head8", null: false
    t.text "answer"
    t.bigint "category_id", default: 0
    t.index ["category_id"], name: "index_prompts_on_category_id"
  end

  add_foreign_key "prompts", "categories"
end
