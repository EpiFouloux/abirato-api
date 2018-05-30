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

ActiveRecord::Schema.define(version: 2018_05_30_173153) do

  create_table "character_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "power", limit: 1, null: false
    t.integer "control", limit: 1, null: false
    t.integer "swiftness", limit: 1, null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_natures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "power", limit: 1, null: false
    t.integer "control", limit: 1, null: false
    t.integer "swiftness", limit: 1, null: false
    t.integer "strength", limit: 1, null: false
    t.integer "consitution", limit: 1, null: false
    t.integer "dexterity", limit: 1, null: false
    t.integer "intelligence", limit: 1, null: false
  end

  create_table "characters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level", limit: 1, default: 0, null: false
    t.integer "experience_amount", default: 0, null: false
    t.integer "additive_power", limit: 1, default: 0, null: false
    t.integer "additive_swiftness", limit: 1, default: 0, null: false
    t.integer "additive_control", limit: 1, default: 0, null: false
    t.integer "additive_strength", limit: 1, default: 0, null: false
    t.integer "additive_constitution", limit: 1, default: 0, null: false
    t.integer "additive_dexterity", limit: 1, default: 0, null: false
    t.integer "additive_intelligence", limit: 1, default: 0, null: false
    t.decimal "grown_strength", precision: 10, default: "0", null: false
    t.decimal "grown_consitution", precision: 10, default: "0", null: false
    t.decimal "grown_dexterity", precision: 10, default: "0", null: false
    t.decimal "grown_intelligence", precision: 10, default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "natures_id"
    t.bigint "character_classes_id"
    t.bigint "template_characters_id"
    t.bigint "users_id"
    t.index ["character_classes_id"], name: "index_characters_on_character_classes_id"
    t.index ["natures_id"], name: "index_characters_on_natures_id"
    t.index ["template_characters_id"], name: "index_characters_on_template_characters_id"
    t.index ["users_id"], name: "index_characters_on_users_id"
  end

  create_table "template_characters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "natures_id"
    t.index ["natures_id"], name: "index_template_characters_on_natures_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
