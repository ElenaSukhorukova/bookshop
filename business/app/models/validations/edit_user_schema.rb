module Validations
  class EditUserSchema < ApplicationContract
    schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?, min_size?: 8)
      optional(:password_confirmation).filled(:str?)
    end

    rule(:email).validate(:email_format)
    rule(:password).validate(:password_format)
    rule(:password, :email).validate(:password_exclusion)
    rule(:password, :password_confirmation).validate(:password_similarity)
  end
end
