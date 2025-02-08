module Validations
  class UserSchema < ApplicationContract
    schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?, min_size?: 8)
      required(:password_confirmation).filled(:str?)
      required(:role).filled(:str?)
    end

    rule(:email).validate(:email_format)
    rule(:password).validate(:password_format)
    rule(:password, :email).validate(:password_exclusion)
    rule(:password, :password_confirmation).validate(:password_similarity)

    rule(:role) do
      key.failure(:unsupported_role) if value != 'customer'
    end
  end
end
