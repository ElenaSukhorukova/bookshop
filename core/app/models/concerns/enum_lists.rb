module EnumLists
  extend ActiveSupport::Concern

  USER_ROLES = %w[
    customer employee admin
  ].freeze
end
