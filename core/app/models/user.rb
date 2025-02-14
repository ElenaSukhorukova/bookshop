class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), prefix: :role, validate: true

  before_save :validate_uniq_admin_role

  scope :admin_user, -> { where(role: 'admin') }

  private

  def validate_uniq_admin_role
    if User.admin_user.present?
      abort "It should be only one admin!"
    end
  end
end
