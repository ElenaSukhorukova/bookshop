class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), prefix: :role, validate: true

  before_validation ->(user) { abort "It should be only one admin!" if user.class.admin_user.present? }
  after_save :send_message_to_business

  scope :admin_user, -> { where(role: 'admin') }

  private

  def send_message_to_business
    Karafka.producer.produce_sync(topic: 'users', payload: self.as_json.to_json)
  end
end
