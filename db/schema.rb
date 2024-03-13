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

ActiveRecord::Schema[7.1].define(version: 2024_03_13_012000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "email"
    t.string "phone_number"
    t.bigint "practitioner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "health_fund_id"
    t.index ["practitioner_id"], name: "index_clients_on_practitioner_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "practitioner_id", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_consultations_on_client_id"
    t.index ["practitioner_id"], name: "index_consultations_on_practitioner_id"
  end

  create_table "health_funds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practitioners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "ahpra_number"
    t.string "phone_number"
    t.index ["email"], name: "index_practitioners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_practitioners_on_reset_password_token", unique: true
  end

  create_table "provider_numbers", force: :cascade do |t|
    t.string "health_fund"
    t.string "provider_number"
    t.bigint "practitioner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "health_fund_id"
    t.index ["practitioner_id"], name: "index_provider_numbers_on_practitioner_id"
  end

  add_foreign_key "clients", "practitioners"
  add_foreign_key "consultations", "clients"
  add_foreign_key "consultations", "practitioners"
  add_foreign_key "provider_numbers", "practitioners"
end
