module Validations
  class ApplicationContract < Dry::Validation::Contract
    config.messages.backend = :i18n

    register_macro(:email_format) do
      key.failure(:format) unless /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/.match?(value)
    end

    register_macro(:password_format) do
      key.failure(:format) unless /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{8,}$/.match?(value)
    end

    register_macro(:password_exclusion) do
      key.failure(:password_exclusion) if values[:password] == values[:email]
    end

    register_macro(:password_similarity) do
      if values[:password].present? && (values[:password] != values[:password_confirmation])
        key.failure(:password_similarity)
      end
    end
  end
end
