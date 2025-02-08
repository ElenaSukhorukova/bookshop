# t.string "uid", null: false
# t.bigint "user_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["uid"], name: "unique_sessions", unique: true
# t.index ["user_id"], name: "index_sessions_on_user_id"

class Session < ApplicationRecord
  belongs_to :user
end
