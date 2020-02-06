# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_06_003337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audiences", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "ch_number"
    t.string "objective"
    t.integer "target_word_count"
    t.text "overview"
    t.boolean "currently_writing", default: false
    t.integer "story_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_chapters", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.integer "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.string "traits"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portrait_file_name"
    t.string "portrait_content_type"
    t.bigint "portrait_file_size"
    t.datetime "portrait_updated_at"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "story_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.integer "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "stories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "target_word_count"
    t.text "overview"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_file_name"
    t.string "cover_content_type"
    t.bigint "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "story_audiences", id: :serial, force: :cascade do |t|
    t.integer "story_id"
    t.integer "audience_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "story_genres", id: :serial, force: :cascade do |t|
    t.integer "story_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.string "username"
    t.text "bio"
    t.string "full_name"
    t.string "provider"
    t.string "uid"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
