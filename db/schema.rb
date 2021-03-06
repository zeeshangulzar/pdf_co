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

ActiveRecord::Schema.define(version: 2020_10_02_042834) do

  create_table "log_histories", force: :cascade do |t|
    t.string "path"
    t.string "http_type"
    t.json "request_parameters"
    t.json "response_parameters"
    t.string "response_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "error"
    t.index ["http_type"], name: "index_log_histories_on_http_type"
    t.index ["path"], name: "index_log_histories_on_path"
    t.index ["response_code"], name: "index_log_histories_on_response_code"
  end

end
