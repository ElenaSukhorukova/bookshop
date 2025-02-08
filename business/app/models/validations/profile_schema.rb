module Validations
  class SessionSchema < ApplicationContract
    schema do
      required(:birthday).filled(:str?)
      # required(:first_name).filled(:str?, min_size?: 3)
      # required(:first_name).filled(:str?, min_size?: 3)
      # required(:phone_number).filled(:str?)
    end

    rule(:birthday) do
      # unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      #   key.failure('has invalid format')
      # end
    end

    # rule(:birthday).validate(:email_format)
    # rule(:password).validate(:password_format)
    # rule(:password, :email).validate(:password_exclusion)
    # rule(:password, :password_confirmation).validate(:password_similarity)

    # rule(:role) do
    #   key.failure(:unsupported_role) if value != 'customer'
    # end
  end
end
