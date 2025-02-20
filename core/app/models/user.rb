class User < ApplicationRecord
  validate :uniq_user_admin, on: :create
  validate :unchangebale_role, on: :update

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), prefix: :role, validate: true

  scope :admin_user, -> { where(role: 'admin').take }

  def admin?
    role_admin?
  end

  private

  def uniq_user_admin
    if role_admin? && User.admin_user.present?
      errors.add(:role, "should be only one admin!")
    end
  end

  def unchangebale_role
    errors.add(:role, 'can\'t be changed') if role_changed?
  end
end
