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

ActiveRecord::Schema.define(version: 2018_06_09_212054) do

  create_table "character_classes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "power", limit: 1, null: false
    t.integer "control", limit: 1, null: false
    t.integer "swiftness", limit: 1, null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "class_type", null: false
    t.integer "skill_id"
  end

  create_table "character_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "event_date", null: false
    t.string "event_type", null: false
    t.text "event_data", null: false
    t.bigint "character_instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_instance_id"], name: "index_character_events_on_character_instance_id"
  end

  create_table "character_instances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.decimal "grown_constitution", precision: 10, default: "0", null: false
    t.decimal "grown_dexterity", precision: 10, default: "0", null: false
    t.decimal "grown_intelligence", precision: 10, default: "0", null: false
    t.bigint "character_nature_id"
    t.bigint "character_special_class_id"
    t.bigint "character_template_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "character_prestigious_class_id"
    t.bigint "character_legendary_class_id"
    t.index ["character_legendary_class_id"], name: "index_character_instances_on_character_legendary_class_id"
    t.index ["character_nature_id"], name: "index_character_instances_on_character_nature_id"
    t.index ["character_prestigious_class_id"], name: "index_character_instances_on_character_prestigious_class_id"
    t.index ["character_special_class_id"], name: "index_character_instances_on_character_special_class_id"
    t.index ["character_template_id"], name: "index_character_instances_on_character_template_id"
    t.index ["user_id"], name: "index_character_instances_on_user_id"
  end

  create_table "character_natures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "power", limit: 1, null: false
    t.integer "control", limit: 1, null: false
    t.integer "swiftness", limit: 1, null: false
    t.integer "strength", limit: 1, null: false
    t.integer "constitution", limit: 1, null: false
    t.integer "dexterity", limit: 1, null: false
    t.integer "intelligence", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "character_nature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "icon_id"
    t.integer "picture_id"
    t.integer "model_id"
    t.integer "skill_one_id"
    t.integer "skill_two_id"
    t.integer "skill_three_id"
    t.text "description"
    t.boolean "enabled", default: true
    t.index ["character_nature_id"], name: "index_character_templates_on_character_nature_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level", default: 0, null: false
    t.integer "experience_amount", default: 0, null: false
  end

  add_foreign_key "character_events", "character_instances"
  add_foreign_key "character_instances", "character_classes", column: "character_legendary_class_id"
  add_foreign_key "character_instances", "character_classes", column: "character_prestigious_class_id"
  add_foreign_key "character_instances", "character_classes", column: "character_special_class_id"
  add_foreign_key "character_instances", "character_natures"
  add_foreign_key "character_instances", "character_templates"
  add_foreign_key "character_instances", "users"
  add_foreign_key "character_templates", "character_natures"
end
