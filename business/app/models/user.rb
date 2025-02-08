# frozen_string_literal: true

# t.string "email", null: false
# t.string "password_digest"
# t.string "remember_digest"
# t.boolean "activated", default: false, null: false
# t.datetime "activated_at"
# t.string "activation_digest"
# t.string "reset_digest"
# t.datetime "reset_sent_at"
# t.string "provider"
# t.jsonb "provider_settings"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.enum "role", default: "customer", enum_type: "user_role"
# t.datetime "deleted_at"
# t.string "google_secret"
# t.integer "mfa_secret"
# t.index ["deleted_at"], name: "index_users_on_deleted_at"
# t.index ["email"], name: "unique_emails", unique: true

class User < ApplicationRecord
  include User::Authorization

  attribute :remember_token, :string

  generates_token_for :remember_token, expires_in: 14.days
  generates_token_for :activation_token, expires_in: 15.minutes
  generates_token_for :reset_token, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  has_secure_password
  has_secure_password :recovery_password, validations: false

  has_one :profile, dependent: :destroy
  has_many :sessions, dependent: :destroy

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), _prefix: :role, validate: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  before_save :make_normalize

  private

  def make_normalize
    normalize_attribute(:email)
  end
end
